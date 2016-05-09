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


public typealias PushNotificationsCompletionHandler = (error: PushNotificationsError?) -> Void


public struct PushNotifications {
    
    
    public struct Region {
        
        public static let DALLAS = "ng.bluemix.net"
        public static let LONDON = "eu-gb.bluemix.net"
        public static let SYDNEY = "au-syd.bluemix.net"
    }
    
    
    internal let httpResource: HttpResource
    internal let headers: [String: String]
    
    
    public init(bluemixRegion: String, bluemixAppGuid: String, bluemixAppSecret: String) {
        
        let bluemixHost = "imfpush." + bluemixRegion
        
        httpResource = HttpResource(schema: "https", host: bluemixHost, port: "443", path: "/imfpush/v1/apps/\(bluemixAppGuid)/messages")
        
        headers = ["appSecret": bluemixAppSecret, "Content-Type": "application/json"]
    }
    
    public func send(notification: Notification, completionHandler: PushNotificationsCompletionHandler?) {
        
        guard let jsonObject = notification.jsonFormat else {
            completionHandler?(error: PushNotificationsError.InvalidNotification)
            return
        }
        
        guard let requestBody = try? NSJSONSerialization.data(withJSONObject: jsonObject, options: NSJSONWritingOptions(rawValue: 0)) else {
            completionHandler?(error: PushNotificationsError.InvalidNotification)
            return
        }
        
        HttpClient.post(resource: httpResource, headers: headers, data: requestBody) { (error, status, headers, data) in
            
            switch error {
                
            case HttpError.Unauthorized?:
                completionHandler?(error: PushNotificationsError.Unauthorized)
            case HttpError.NotFound?:
                completionHandler?(error: PushNotificationsError.InvalidAppGuid)
            case HttpError.ServerError?:
                completionHandler?(error: PushNotificationsError.ServerError)
            case HttpError.ConnectionFailure?:
                completionHandler?(error: PushNotificationsError.ConnectionFailure)
            default:
                completionHandler?(error: nil)
            }
        }
    }
}

