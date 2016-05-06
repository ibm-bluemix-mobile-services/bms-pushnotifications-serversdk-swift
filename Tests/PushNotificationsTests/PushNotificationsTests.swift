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
@testable import BluemixPushNotifications


class BluemixPushNotificationsTests: XCTestCase {
    
    
    override func setUp() {
        super.setUp()
    }
    
    
    override func tearDown() {
        super.tearDown()
    }
    
    
    // MARK: - PushNotifications tests
    
    
    func testPushNotificationsInitializer(){
        
        let pushExample = PushNotifications(bluemixRegion: PushNotifications.Region.DALLAS, bluemixAppGuid: "abcd", bluemixAppSecret: "1234")
        
        XCTAssertEqual(pushExample.headers["Content-Type"], "application/json")
        XCTAssertEqual(pushExample.headers["appSecret"], "1234")

        // Note: The HttpResource cannot be checked for validity since none of its properties can be accessed (they are all internal to SimpleHttpClient)
    }
    
    
    // MARK: - Notification tests
    
    
    // MARK: With values
    
    
    func testNotificationJsonFormatWithValues() {
        
        let expectedJsonData = try! NSJSONSerialization.data(withJSONObject: notificationExampleJson, options: NSJSONWritingOptions(rawValue: 0))
        let notificationJsonData = try! NSJSONSerialization.data(withJSONObject: notificationExample.jsonFormat!, options: NSJSONWritingOptions(rawValue: 0))
        
        XCTAssertEqual(notificationJsonData, expectedJsonData)
    }
    
    
    func testMessageJsonFormatWithValues() {
        
        let expectedJsonData = try! NSJSONSerialization.data(withJSONObject: messageExampleJson, options: NSJSONWritingOptions(rawValue: 0))
        let messageJsonData = try! NSJSONSerialization.data(withJSONObject: messageExample.jsonFormat!, options: NSJSONWritingOptions(rawValue: 0))
        
        XCTAssertEqual(messageJsonData, expectedJsonData)
    }
    
    
    func testTargetJsonFormatWithValues() {
        
        let expectedJsonData = try! NSJSONSerialization.data(withJSONObject: targetExampleJson, options: NSJSONWritingOptions(rawValue: 0))
        let targetJsonData = try! NSJSONSerialization.data(withJSONObject: targetExample.jsonFormat!, options: NSJSONWritingOptions(rawValue: 0))
        
        XCTAssertEqual(targetJsonData, expectedJsonData)
    }
    
    
    func testSettingsJsonFormatWithValues() {
        
        let expectedJsonData = try! NSJSONSerialization.data(withJSONObject: settingsExampleJson, options: NSJSONWritingOptions(rawValue: 0))
        let settingsJsonData = try! NSJSONSerialization.data(withJSONObject: settingsExample.jsonFormat!, options: NSJSONWritingOptions(rawValue: 0))
        
        XCTAssertEqual(settingsJsonData, expectedJsonData)
    }
    
    
    func testApnsJsonFormatWithValues() {
        
        let expectedJsonData = try! NSJSONSerialization.data(withJSONObject: apnsExampleJson, options: NSJSONWritingOptions(rawValue: 0))
        let apnsJsonData = try! NSJSONSerialization.data(withJSONObject: apnsExample.jsonFormat!, options: NSJSONWritingOptions(rawValue: 0))
        
        XCTAssertEqual(apnsJsonData, expectedJsonData)
    }
    

    func testGcmJsonFormatWithValues() {
        
        let gcmJsonData = try! NSJSONSerialization.data(withJSONObject: gcmExample.jsonFormat!, options: NSJSONWritingOptions(rawValue: 0))
        let expectedJsonData = try! NSJSONSerialization.data(withJSONObject: gcmExampleJson, options: NSJSONWritingOptions(rawValue: 0))
        
        XCTAssertEqual(gcmJsonData, expectedJsonData)
    }
    
    
    // MARK: With Nil
    
    
    func testNotificationJsonWithNil() {
        
        let emptyMessage = Notification.Message(alert: nil, url: nil)
        let notification = Notification(message: emptyMessage, target: nil, settings: nil)
        XCTAssertNil(notification.jsonFormat)
    }
    
    func testMessageJsonWithNil() {
        
        let emptyMessage = Notification.Message(alert: nil, url: nil)
        XCTAssertNil(emptyMessage.jsonFormat)
    }
    
    
    func testTargetJsonWithNil() {
        
        let emptyTarget = Notification.Target(deviceIds: nil, platforms: nil, tagNames: nil, userIds: nil)
        XCTAssertNil(emptyTarget.jsonFormat)
    }
    
    
    func testSettingsJsonWithNil() {
        
        let emptySettings = Notification.Settings(apns: nil, gcm: nil)
        XCTAssertNil(emptySettings.jsonFormat)
    }
    
    
    func testApnsJsonFormatWithNil() {
        
        let emptyApns = Notification.Settings.Apns(badge: nil, category: nil, iosActionKey: nil, payload: nil, sound: nil, type: nil)
        XCTAssertNil(emptyApns.jsonFormat)
    }

    
    func testGcmJsonFormatWithNil() {
        
        let emptyGcm = Notification.Settings.Gcm(collapseKey: nil, delayWhileIdle: nil, payload: nil, priority: nil, sound: nil, timeToLive: nil)
        XCTAssertNil(emptyGcm.jsonFormat)
    }
}


// MARK: - Notification examples


private let apnsExample = Notification.Settings.Apns(badge: 0, category: "a", iosActionKey: "b", payload: ["c": ["d": "e"]], sound: "f", type: ApnsType.DEFAULT)
private let apnsExampleJson: [String: AnyObject] = ["badge": 0, "category": "a", "iosActionKey": "b", "payload": ["c": ["d": "e"]], "sound": "f", "type": "DEFAULT"]

private let gcmExample = Notification.Settings.Gcm(collapseKey: "a", delayWhileIdle: false, payload: "c", priority: GcmPriority.DEFAULT, sound: "e", timeToLive: 1.0)
private let gcmExampleJson: [String: AnyObject] = ["collapseKey": "a", "delayWhileIdle": "false", "payload": "c", "priority": "DEFAULT", "sound": "e", "timeToLive": 1.0]

private let settingsExample = Notification.Settings(apns: apnsExample, gcm: gcmExample)
private let settingsExampleJson: [String: AnyObject] = ["apns": apnsExampleJson, "gcm": gcmExampleJson]

private let targetExample = Notification.Target(deviceIds: ["a"], platforms: [TargetPlatform.Apple, TargetPlatform.Google], tagNames: ["c"], userIds: ["d"])
private let targetExampleJson: [String: AnyObject] = ["tagNames": ["c"], "platforms": ["A", "G"],  "userIds": ["d"], "deviceIds": ["a"]]

private let messageExample = Notification.Message(alert: "a", url: "b")
private let messageExampleJson: [String: AnyObject] = ["alert": "a", "url": "b"]

private let notificationExample = Notification(message: messageExample, target: targetExample, settings: settingsExample)
private let notificationExampleJson: [String: AnyObject] = ["message": messageExampleJson, "target": targetExampleJson, "settings": settingsExampleJson]


// MARK: - Linux requirement


extension BluemixPushNotificationsTests {
    static var allTests : [(String, BluemixPushNotificationsTests -> () throws -> Void)] {
        return [
            ("testNotificationJsonFormatWithValues", testNotificationJsonFormatWithValues),
            ("testMessageJsonFormatWithValues", testMessageJsonFormatWithValues),
            ("testTargetJsonFormatWithValues", testTargetJsonFormatWithValues),
            ("testSettingsJsonFormatWithValues", testSettingsJsonFormatWithValues),
            ("testApnsJsonFormatWithValues", testApnsJsonFormatWithValues),
            ("testGcmJsonFormatWithValues", testGcmJsonFormatWithValues),
            ("testNotificationJsonWithNil", testNotificationJsonWithNil),
            ("testMessageJsonWithNil", testMessageJsonWithNil),
            ("testTargetJsonWithNil", testTargetJsonWithNil),
            ("testSettingsJsonWithNil", testSettingsJsonWithNil),
            ("testApnsJsonFormatWithNil", testApnsJsonFormatWithNil),
            ("testGcmJsonFormatWithNil", testGcmJsonFormatWithNil),
        ]
    }
}