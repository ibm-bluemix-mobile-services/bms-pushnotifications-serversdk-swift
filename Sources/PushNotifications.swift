/*
 *     Copyright 2016 IBM Corp.
 *     Licensed under the Apache License, Version 2.0 (the "License");
 *     you may not use this file except in compliance with the License.
 *     You may obtain a copy of the License at
 *     http://www.apache.org/licenses/LICENSE-2.0
 *     Unless required by applicable law or agreed to in writing, software
 *     distributed under the License is distributed on an "AS IS" BASIS,
 *     WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *     See the License for the specific language governing permissions and
 *     limitations under the License.
 */


import Foundation
import SimpleHttpClient


/**
    The type of callback to send with PushNotifications requests.
*/
public typealias PushNotificationsCompletionHandler = (_ data: Data?,_ status: Int?,_ error: PushNotificationsError?) -> Void


/**
    Used to send Push notifications via a IBM Cloud Push Notifications service.
*/
public class PushNotifications {
    
    
    /// The IBM Cloud region where the Push Notifications service is hosted.
    public struct Region {
        
        public static let US_SOUTH = "ng.bluemix.net"
        public static let UK = "eu-gb.bluemix.net"
        public static let SYDNEY = "au-syd.bluemix.net"
        public static let FRANKFURT = "eu-de.bluemix.net"
        public static let US_EAST = "us-east.bluemix.net"
    }
    
    
    internal var headers = [String: String]()
    private var httpResource = HttpResource(schema: "", host: "")
    private var httpBulkResource = HttpResource(schema: "", host: "")
    private var pushApiKey = ""
    private var pushAppRegion = ""

    // used to test in test zone and dev zone
    public static var overrideServerHost = "";
    
    /**
        Initialize PushNotifications by supplying the information needed to connect to the IBM Cloud Push Notifications service.
     
        - parameter pushRegion: The IBM Cloud region where the Push Notifications service is hosted.
        - parameter pushAppGuid: The app GUID for the IBM Cloud application that the Push Notifications service is bound to.
        - parameter pushAppSecret: The appSecret credential required for Push Notifications service authorization.
    */
    public init(pushRegion: String, pushAppGuid: String, pushAppSecret: String) {
        
        headers = ["appSecret": pushAppSecret, "Content-Type": "application/json"]
        
        if(PushNotifications.overrideServerHost.isEmpty){

            var pushHost = "imfpush." + pushRegion
            
            httpResource = HttpResource(schema: "https", host: pushHost, port: "443", path: "/imfpush/v1/apps/\(pushAppGuid)/messages")
            httpBulkResource = HttpResource(schema: "https", host: pushHost, port: "443", path: "/imfpush/v1/apps/\(pushAppGuid)/messages/bulk")

            
        }else{
            
            let url = URL(string: PushNotifications.overrideServerHost)
            httpResource = HttpResource(schema: (url?.scheme)!, host: (url?.host)!, path: "/imfpush/v1/apps/\(pushAppGuid)/messages")
            httpBulkResource = HttpResource(schema: (url?.scheme)!, host: (url?.host)!, path: "/imfpush/v1/apps/\(pushAppGuid)/messages/bulk")
        }
    }
    
    /**
     Initialize PushNotifications by supplying the information needed to connect to the IBM Cloud Push Notifications service.
     
     - parameter pushRegion: The IBM Cloud region where the Push Notifications service is hosted.
     - parameter pushAppGuid: The app GUID for the IBM Cloud application that the Push Notifications service is bound to.
     - parameter pushApiKey: The ApiKey credential required for Push Notifications service authorization.
     */
    public init(pushApiKey:String, pushAppGuid: String, pushRegion: String) {
        
        self.pushApiKey = pushApiKey
        self.pushAppRegion = pushRegion
        if(PushNotifications.overrideServerHost.isEmpty) {
            let pushHost = "imfpush." + pushRegion
            
            httpResource = HttpResource(schema: "https", host: pushHost, port: "443", path: "/imfpush/v1/apps/\(pushAppGuid)/messages")
            httpBulkResource = HttpResource(schema: "https", host: pushHost, port: "443", path: "/imfpush/v1/apps/\(pushAppGuid)/messages/bulk")
        } else {
            let url = URL(string: PushNotifications.overrideServerHost)
            httpResource = HttpResource(schema: (url?.scheme)!, host: (url?.host)!, path: "/imfpush/v1/apps/\(pushAppGuid)/messages")
            httpBulkResource = HttpResource(schema: (url?.scheme)!, host: (url?.host)!, path: "/imfpush/v1/apps/\(pushAppGuid)/messages/bulk")
        }
    }
    
    
    /**
     This method will get an iam auth token from the server and add it to the request header. Get Auth token before calling any send methods. 
     - parameter completionHandler: Returns true if there is token with token string
    */
    public func getAuthToken(completionHandler: @escaping (_ hasToken:Bool?, _ tokenValue: String) -> Void) {
        if (pushApiKey != "" && pushAppRegion != "") {
            
            var regionString = pushAppRegion;
            if (!PushNotifications.overrideServerHost.isEmpty) {
                let url = URL(string: PushNotifications.overrideServerHost)
                let domain = url?.host
                if let splitStringArray = domain?.split(separator: ".", maxSplits: 1, omittingEmptySubsequences: true) {
                    regionString = String(splitStringArray[1])
                }
            }
            let pushHost = "iam." + regionString
            let iamHttpResource = HttpResource(schema: "https", host: pushHost, port: "443", path: "/identity/token")
            
            var data:Data?
            let dataString =  "grant_type=urn:ibm:params:oauth:grant-type:apikey&apikey=\(pushApiKey)"
            
            data = dataString.data(using: .ascii, allowLossyConversion: true)
            
            let iamHeaders = ["Content-Type":"application/x-www-form-urlencoded","Accept":"application/json"]
            
            HttpClient.post(resource: iamHttpResource, headers: iamHeaders, data: data) { (error, status, headers, data) in
                
                //completionHandler?(data,status,PushNotificationsError.from(httpError: error))
                if(status == 200) {
                    
                    let dataJson = try! JSONSerialization.jsonObject(with: data!, options:JSONSerialization.ReadingOptions.allowFragments) as! [String:Any]
                    let tokenString = dataJson["access_token"] as? String
                    if !(tokenString?.isEmpty)! {
                        self.headers = ["Authorization": "Bearer " + tokenString!, "Content-Type": "application/json"]
                    }
                    completionHandler(true, tokenString!)
                } else {
                    print("Error While getting the token", error ?? "")
                    completionHandler(false, "")
                }
            }
        } else {
            print("Error : Pass valid Apikey and app region")
            completionHandler(false, "")
        }
    }

    /**
        Send the Push notification. 
     
        - parameter notificiation: The push notification to send.
        - paramter completionHandler: The callback to be executed when the send request completes.
    */
    public func send(notification: Notification, completionHandler: PushNotificationsCompletionHandler?) {

        guard let requestBody = notification.jsonFormat else {
            completionHandler?(nil,500,PushNotificationsError.InvalidNotification)
            return
        }
        guard let data = try? JSONSerialization.data(withJSONObject: requestBody, options: .prettyPrinted) else{
            completionHandler?(nil,500,PushNotificationsError.InvalidNotification)
            return
        }
        
        HttpClient.post(resource: httpResource, headers: headers, data: data) { (error, status, headers, data) in
            
            completionHandler?(data,status,PushNotificationsError.from(httpError: error))
        }
    }

        /**
     Send Bulk Push notification.
     
     - parameter notificiation: Array of push notification payload to send.
     - paramter completionHandler: The callback to be executed when the send request completes.
     */
    public func sendBulk(notification: [Notification], completionHandler: PushNotificationsCompletionHandler?) {
        
        var dataArray = [[String:Any]]()
        for notif in notification {
            
            guard let requestBody = notif.jsonFormat else {
                completionHandler?(nil,500,PushNotificationsError.InvalidNotification)
                return
            }
            dataArray.append(requestBody)
        }

        guard let data = try? JSONSerialization.data(withJSONObject: dataArray, options: .prettyPrinted) else{
            completionHandler?(nil,500,PushNotificationsError.InvalidNotification)
            return
        }
        
        HttpClient.post(resource: httpBulkResource, headers: headers, data: data) { (error, status, headers, data) in
            completionHandler?(data,status,PushNotificationsError.from(httpError: error))
        }
    }
}

