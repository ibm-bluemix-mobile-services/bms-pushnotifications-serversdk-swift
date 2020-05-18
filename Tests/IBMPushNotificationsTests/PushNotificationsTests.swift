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


import XCTest
import SimpleHttpClient
@testable import IBMPushNotifications


class IBMPushNotificationsTests: XCTestCase {


    override func setUp() {
        super.setUp()
    }


    override func tearDown() {
        super.tearDown()
    }


    // MARK: - PushNotifications tests


    func testPushNotificationsInitializer(){

        let pushExample = PushNotifications(pushRegion: PushNotifications.Region.US_SOUTH, pushAppGuid: "abcd", pushAppSecret: "1234")

        XCTAssertEqual(pushExample.headers["Content-Type"], "application/json")
        XCTAssertEqual(pushExample.headers["appSecret"], "1234")

        // Note: The HttpResource cannot be checked for validity since none of its properties can be accessed (they are all internal to SimpleHttpClient)
    }
    
    func testPushNotificationsInitializerCustom(){

          let pushExample = PushNotifications(pushRegion: PushNotifications.Region.US_SOUTH, pushAppGuid: "abcd", pushAppSecret: "1234")
        PushNotifications.overrideServerHost = "https://myserver.com"

          XCTAssertEqual(pushExample.headers["Content-Type"], "application/json")
          XCTAssertEqual(pushExample.headers["appSecret"], "1234")

          // Note: The HttpResource cannot be checked for validity since none of its properties can be accessed (they are all internal to SimpleHttpClient)
      }
    
    func testPushNotificationsSend() {
        
        let pushExample = PushNotifications(pushRegion: PushNotifications.Region.US_SOUTH, pushAppGuid: "abcd", pushAppSecret: "1234")
        
        pushExample.send(notification: notificationExample) { (data, status, error) in
            if error != nil {
                print("Failed to send push notification. Error: \(error!)")
            }
           // assert(error == nil, "success send push notification")
        }
    }
    func testPushNotificationsSendError() {
        
        let pushExample = PushNotifications(pushRegion: PushNotifications.Region.US_SOUTH, pushAppGuid: "abcd", pushAppSecret: "1234")
        
        pushExample.send(notification: Notification(message:Notification.Message(alert:nil))) { (data, status, error) in
            if error != nil {
                print("Failed to send push notification. Error: \(error!)")
            }
            assert(error != nil, "Failed to send push notification. Error: \(error!)")
        }
    }

    func testPushNotificationsSendBulk() {
        
        let pushExample = PushNotifications(pushRegion: PushNotifications.Region.US_SOUTH, pushAppGuid: "abcd", pushAppSecret: "1234")
        
        pushExample.sendBulk(notification: bulkNotification) { (data, status, error) in
            if error != nil {
                print("Failed to send Bulk push notification. Error: \(error!)")
            }
          //  assert(error == nil, "success send bulk push notification")
        }
    }

    func testPushNotificationsSendBulkError() {
        
        let pushExample = PushNotifications(pushRegion: PushNotifications.Region.US_SOUTH, pushAppGuid: "abcd", pushAppSecret: "1234")
        
        pushExample.sendBulk(notification: [Notification(message:Notification.Message(alert:nil))]) { (data, status, error) in
            if error != nil {
                print("Failed to send Bulk push notification. Error: \(error!)")
            }
            assert(error != nil, "Failed to send push notification. Error: \(error!)")
        }
    }

    func testHttpError() {
        
        let error1 = PushNotificationsError.ConnectionFailure
        let error3 = PushNotificationsError.Unauthorized
        let error4 = PushNotificationsError.NotFound
        let error5 = PushNotificationsError.ServerError
        
        assert(PushNotificationsError.from(httpError: nil) == nil, "Nill error")
        assert(PushNotificationsError.from(httpError: HttpError.Unauthorized) == error3, "Unauthorized error")
        assert(PushNotificationsError.from(httpError: HttpError.NotFound) == error4, "NotFound error")
        assert(PushNotificationsError.from(httpError: HttpError.ServerError) == error5, "ServerError error")
        assert(PushNotificationsError.from(httpError: HttpError.ConnectionFailure) == error1, "ConnectionFailure error")
        assert(PushNotificationsError.from(httpError: HttpError.ConnectionFailure) == error1, "ConnectionFailure error")


    }


    // MARK: - Notification tests


    // MARK: With values




    func testMessageJsonFormatWithValues() {
        let messageJson = messageExample.jsonFormat
        let expectedJson = messageExampleJson
        let alert:String = messageJson?["alert"] as! String
        let expectedAlert:String = expectedJson["alert"]!
        XCTAssertEqual(alert, expectedAlert)
    }


    func testTargetJsonFormatWithValues() {
        let targetJson = targetExample.jsonFormat
        let expectedJson = targetExampleJson
        let userIds:[String] = targetJson?["userIds"] as! [String]
        let expecteduserIds:[String] = expectedJson["userIds"]!
        XCTAssertEqual(userIds, expecteduserIds)
    }



    func testGcmJsonFormatWithValues() {
        let gcmJson = gcmExample.jsonFormat
        let expectedJson = gcmExampleJson
        
        let delayWhileIdle:String = gcmJson?["delayWhileIdle"] as! String
        let expectedDelayWhileIdle:String = expectedJson["delayWhileIdle"] as! String

        XCTAssertEqual(delayWhileIdle , expectedDelayWhileIdle)
    }

    // MARK: With Nil


    func testNotificationJsonWithNil() {
        let emptyMessage = Notification.Message(alert: nil, url: nil)
        let notification = Notification(message: emptyMessage, target: nil, apnsSettings: nil, gcmSettings: nil)
        XCTAssertNil(notification.jsonFormat)
    }

    func testMessageJsonWithNil() {
        let emptyMessage = Notification.Message(alert: nil, url: nil)
        XCTAssertNil(emptyMessage.jsonFormat)
    }


    func testTargetJsonWithNil() {
        let emptyTarget = Notification.Target(deviceIds: nil, userIds: nil, platforms: nil, tagNames: nil)
        XCTAssertNil(emptyTarget.jsonFormat)
    }


    func testApnsJsonFormatWithNil() {

        let emptyApns = Notification.Settings.Apns(badge: nil, interactiveCategory: nil, iosActionKey: nil, sound: nil, type: nil, payload: nil)
        XCTAssertNil(emptyApns.jsonFormat)
    }


    func testGcmJsonFormatWithNil() {

        let emptyGcm = Notification.Settings.Gcm(collapseKey: nil, delayWhileIdle: nil, payload: nil, priority: nil, sound: nil, timeToLive: nil)
        XCTAssertNil(emptyGcm.jsonFormat)
    }
	
}


// MARK: - Notification examples
let gcmStyle = Notification.Settings.GcmStyle(type: GcmStyleTypes.picture_notification, title: "title1", url:"https://dummy.com",text: "test", lines: ["line1"])

let lights = Notification.Settings.GcmLights(ledArgb: GcmLED.Black, ledOnMs: 123, ledOffMs: 200)

let gcmExample = Notification.Settings.Gcm(androidTitle:"title", collapseKey: "a", delayWhileIdle: false, payload: ["c": ["d": "e"]], priority: GcmPriority.DEFAULT, sound: "gg.mp3", timeToLive: 2.0, interactiveCategory: "cat1", icon: "icon1",  sync: true, visibility: GcmVisibility.Public, lights: lights, style: gcmStyle, type: FCMType.DEFAULT, groupId:"g1")



let gcmExampleJson:[String:Any] = ["collapseKey": "a", "delayWhileIdle": "false", "priority": "DEFAULT", "sound": "e", "timeToLive": 1.0]

let safariWeb = Notification.Settings.SafariWeb(title:"test",urlArgs:["action1"],action:"View")
let chromeWeb = Notification.Settings.ChromeWeb(title:"test",iconUrl: "https://ico.com",payload: ["c": ["d": "e"]],timeToLive: 9.0)

let chromeAppExt = Notification.Settings.ChromeAppExt(title:"test",iconUrl: "https://ico.com",collapseKey: "colkey1", delayWhileIdle: false, payload: ["c": ["d": "e"]],timeToLive: 9.0)
let firefoXWeb = Notification.Settings.FirefoxWeb(title:"test",iconUrl: "https://ico.com",payload: ["c": ["d": "e"]],timeToLive: 9.0)


let apnsExample = Notification.Settings.Apns(badge: 0, interactiveCategory: "a", iosActionKey: "b", sound: "c", type: ApnsType.DEFAULT)

let apnsExampleJson:[String:Any] = ["badge": 0, "interactiveCategory": "a", "iosActionKey": "b", "sound": "c", "type": "DEFAULT", "payload": ["c": ["d": "e"]]]

let targetExample = Notification.Target(deviceIds: ["a"], userIds: ["u"], platforms: [TargetPlatform.Apple, TargetPlatform.Google], tagNames: ["c"])
let targetExampleJson = ["deviceIds": ["a"], "userIds": ["u"], "platforms": ["A", "G"], "tagNames": ["c"]]

let messageExample = Notification.Message(alert: "a", url: "b")
let messageExampleJson = ["alert": "a", "url": "b"]

let notificationExample = Notification(message: messageExample, target: targetExample, apnsSettings: apnsExample, gcmSettings: gcmExample, firefoxWebSettings: firefoXWeb, chromeWebSettings: chromeWeb, safariWebSettings: safariWeb, chromeAppExtSettings: chromeAppExt)

let notificationExampleJson = ["message": messageExampleJson, "target": targetExampleJson, "settings": ["apns": apnsExampleJson, "gcm": gcmExampleJson]] as [String : Any]

let notificationExample1 = Notification(message: messageExample, target: targetExample, apnsSettings: apnsExample, gcmSettings: gcmExample)
let notificationExample2 = Notification(message: messageExample, target: targetExample, apnsSettings: apnsExample, gcmSettings: gcmExample)
let bulkNotification = [notificationExample,notificationExample1,notificationExample2]



// MARK: - Linux requirement

extension IBMPushNotificationsTests {
    static var allTests : [(String, (IBMPushNotificationsTests) -> () throws -> Void)] {
        return [
			("testPushNotificationsInitializer", testPushNotificationsInitializer),
			("testPushNotificationsSend", testPushNotificationsSend),
			("testGcmJsonFormatWithValues", testGcmJsonFormatWithValues),
			("testMessageJsonFormatWithValues", testMessageJsonFormatWithValues),
            ("testTargetJsonFormatWithValues", testTargetJsonFormatWithValues),
            ("testNotificationJsonWithNil", testNotificationJsonWithNil),
            ("testMessageJsonWithNil", testMessageJsonWithNil),
            ("testTargetJsonWithNil", testTargetJsonWithNil),
            ("testApnsJsonFormatWithNil", testApnsJsonFormatWithNil),
            ("testGcmJsonFormatWithNil", testGcmJsonFormatWithNil),
            ("testPushNotificationsSend", testPushNotificationsSendBulk)
        ]
    }
}
