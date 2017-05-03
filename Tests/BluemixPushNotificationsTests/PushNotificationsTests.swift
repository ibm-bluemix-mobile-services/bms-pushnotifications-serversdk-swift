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
import SwiftyJSON
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
        
        let pushExample = PushNotifications(bluemixRegion: PushNotifications.Region.US_SOUTH, bluemixAppGuid: "abcd", bluemixAppSecret: "1234")
        
        XCTAssertEqual(pushExample.headers["Content-Type"], "application/json")
        XCTAssertEqual(pushExample.headers["appSecret"], "1234")
        
        // Note: The HttpResource cannot be checked for validity since none of its properties can be accessed (they are all internal to SimpleHttpClient)
    }
    
    
    // MARK: - Notification tests
    
    
    // MARK: With values
    
    
    func testNotificationJsonFormatWithValues() {
        let notificationJson = notificationExample.jsonFormat
        let expectedJson = notificationExampleJson
        XCTAssertEqual(notificationJson, expectedJson)
        XCTAssertNotNil(try? notificationJson?.rawData() as Any)
    }
    
    
    func testMessageJsonFormatWithValues() {
        let messageJson = messageExample.jsonFormat
        let expectedJson = messageExampleJson
        XCTAssertEqual(messageJson, expectedJson)
        XCTAssertNotNil(try? messageJson?.rawData() as Any)
    }
    
    
    func testTargetJsonFormatWithValues() {
        let targetJson = targetExample.jsonFormat
        let expectedJson = targetExampleJson
        XCTAssertEqual(targetJson, expectedJson)
        XCTAssertNotNil(try? targetJson?.rawData() as Any)
    }
    
    
    func testApnsJsonFormatWithValues() {
        let apnsJson = apnsExample.jsonFormat
        let expectedJson = apnsExampleJson
        XCTAssertEqual(apnsJson, expectedJson)
        XCTAssertNotNil(try? apnsJson?.rawData() as Any)
    }
    
    
    func testGcmJsonFormatWithValues() {
        let gcmJson = gcmExample.jsonFormat
        let expectedJson = gcmExampleJson
        XCTAssertEqual(gcmJson, expectedJson)
        // XCTAssertNotNil(try? gcmJson.rawData() as Any)
    }
    
    func testSafariJsonFormatWithValues() {
        let safariJson = safariExample.jsonFormat
        let expectedJson = safariExampleJson
        XCTAssertEqual(safariJson, expectedJson)
        XCTAssertNotNil(try? safariJson?.rawData() as Any)
    }
    
    func testFirefoxJsonFormatWithValues() {
        let fireFoxJson = firefoxExample.jsonFormat
        let expectedJson = firefoxExampleJson
        XCTAssertEqual(fireFoxJson, expectedJson)
        XCTAssertNotNil(try? fireFoxJson?.rawData() as Any)
    }
    
    func testChromeAppExJsonFormatWithValues() {
        let chromeAppExtJson = chromeAppExtExample.jsonFormat
        let expectedJson = chromeAppExtExampleJson
        XCTAssertEqual(chromeAppExtJson, expectedJson)
        XCTAssertNotNil(try? chromeAppExtJson?.rawData() as Any)
    }
    
    func testChromeJsonFormatWithValues() {
        let chromeJson = chromeExample.jsonFormat
        let expectedJson = chromeExampleJson
        XCTAssertEqual(chromeJson, expectedJson)
        XCTAssertNotNil(try? chromeJson?.rawData() as Any)
    }
    
    // MARK: With Nil
    
    
    func testNotificationJsonWithNil() {
        
        let messageBuilder = MessageBuilder(build: {
            
            $0.alert = nil
            $0.url =  nil
            
        })
        let emptyMessage = Notification.Message(messageBuilder: messageBuilder)
        
        let targetBuilder = TargetBuilder(build: {
            
            $0.deviceIds = nil
            $0.userIds = nil
            $0.platforms = nil
            $0.tagNames = nil
            
        })
        let emptyTarget = Notification.Target(targetBuilder: targetBuilder)
        
        let settingsBuilder = SettingsBuilder(build: {
            
            $0.apns = nil
            $0.gcm = nil
            $0.safari = nil
            $0.firefox = nil
            $0.chromeAppExtension = nil
            $0.chrome = nil
            
        })
        
        let emptySettings = Notification.Settings(settingsBuilder: settingsBuilder)
        let notificationBuilder = NotificationBuilder(build: {
            
            $0.message = emptyMessage
            $0.target = emptyTarget
            $0.settings = emptySettings
        })
        let notification = Notification(notificationBuilder:notificationBuilder)
        XCTAssertNil(notification.jsonFormat)
    }
    
    func testMessageJsonWithNil() {
        
        let messageBuilder = MessageBuilder(build: {
            
            $0.alert = nil
            $0.url =  nil
            
        })
        let emptyMessage = Notification.Message(messageBuilder: messageBuilder)
        XCTAssertNil(emptyMessage.jsonFormat)
    }
    
    
    func testTargetJsonWithNil() {
        
        let targetBuilder = TargetBuilder(build: {
            
            $0.deviceIds = nil
            $0.userIds =  nil
            $0.platforms = nil
            $0.tagNames = nil
            
        })
        
        let emptyTarget = Notification.Target(targetBuilder: targetBuilder)
        XCTAssertNil(emptyTarget.jsonFormat)
    }
    
    
    func testApnsJsonFormatWithNil() {
        
        let apnsBuilder = ApnsBuilder(build: {
            
            $0.badge = nil
            $0.interactiveCategory=nil
            $0.iosActionKey=nil
            $0.sound=nil
            $0.type=nil
            $0.payload=nil
            $0.titleLocKey=nil
            $0.locKey=nil
            $0.launchImage=nil
            $0.titleLocArgs = nil
            $0.locArgs=nil
            $0.subtitle=nil
            $0.title=nil
            $0.attachmentUrl=nil
        })
        let emptyApns = Notification.Settings.Apns(apnsBuilder:apnsBuilder)
        XCTAssertNil(emptyApns.jsonFormat)
    }
    
    
    func testGcmJsonFormatWithNil() {
        
        let gcmBuilder = GcmBuilder(build: {
            
            $0.collapseKey = nil
            $0.interactiveCategory=nil
            $0.delayWhileIdle = nil
            $0.payload = nil
            $0.priority = nil
            $0.sound = nil
            $0.timeToLive = nil
            $0.icon = nil
            $0.sync = nil
            $0.visibility = nil
            $0.style = nil
            $0.lights = nil
        })
        
        let emptyGcm = Notification.Settings.Gcm(gcmBuilder:gcmBuilder)
        XCTAssertNil(emptyGcm.jsonFormat)
    }
    
    func testSafariJsonFormatWithNil() {
        
        let safariBuilder = SafariBuilder(build: {
            
            $0.title = nil
            $0.urlArgs = nil
            $0.action = nil
            
        })
        
        let emptyGcm = Notification.Settings.Safari(safariBuilder:safariBuilder)
        XCTAssertNil(emptyGcm.jsonFormat)
    }
    
    func testFirefoxJsonFormatWithNil() {
        
        let firefoxBuilder = FirefoxBuilder(build: {
            
            $0.title = nil
            $0.iconUrl = nil
            $0.timeToLive = nil
            $0.payload = nil
            
        })
        
        let emptyGcm = Notification.Settings.Firefox(firefoxBuilder:firefoxBuilder)
        XCTAssertNil(emptyGcm.jsonFormat)
    }
    
    func testChromeAppExtJsonFormatWithNil() {
        
        let chromeAppExtBuilder = ChromAppExtBuilder(build: {
            
            $0.collapseKey = nil
            $0.delayWhileIdle = nil
            $0.title = nil
            $0.iconUrl = nil
            $0.timeToLive = nil
            $0.payload = nil
            
            
        })
        
        let emptyGcm = Notification.Settings.ChromAppExtension(chromeAppExtBuilder:chromeAppExtBuilder)
        XCTAssertNil(emptyGcm.jsonFormat)
    }
    
    func testChromeJsonFormatWithNil() {
        
        let chromeBuilder = ChromeBuilder(build: {
            
            $0.title = nil
            $0.iconUrl = nil
            $0.timeToLive = nil
            $0.payload = nil
            
        })
        
        
        let emptyGcm = Notification.Settings.Chrome(chromeBuilder:chromeBuilder)
        XCTAssertNil(emptyGcm.jsonFormat)
    }
}


// MARK: - Notification examples


let gcmBuilder = GcmBuilder(build: {
    
    $0.collapseKey = "a"
    $0.interactiveCategory = "b"
    $0.delayWhileIdle = false
    $0.payload = ["c": ["d": "e"]]
    $0.priority = GcmPriority.DEFAULT
    $0.sound = "e"
    $0.timeToLive = 1.0
    $0.icon = "g"
    $0.sync = false
    $0.visibility = Visibility.PUBLIC
    $0.style = Notification.Settings.GcmStyle(gcmStyleBuilder:GcmStyleBuilder(build: {
        
        $0.type = GcmStyleTypes.BIGTEXT_NOTIFICATIION
        $0.title = "title"
        $0.url = "url"
        $0.text = "text"
        $0.lines = ["lines"]
    })).jsonFormat
    $0.lights = Notification.Settings.GcmLights(gcmLightsBuilder: GcmLightsBuilder(build:{
        
        $0.ledArgb = GcmLED.BLACK
        $0.ledOnMs = 2
        $0.ledOffMs = 2
        
    })).jsonFormat
})

let apnsBuilder = ApnsBuilder(build: {
    
    $0.badge = 0
    $0.interactiveCategory = "a"
    $0.iosActionKey = "b"
    $0.sound = "c"
    $0.type = ApnsType.DEFAULT
    $0.payload = ["c":["d":"e"]]
    $0.titleLocKey = "f"
    $0.locKey = "g"
    $0.launchImage = "h"
    $0.titleLocArgs = ["i"]
    $0.locArgs = ["j"]
    $0.subtitle = "k"
    $0.title = "l"
    $0.attachmentUrl = "m"
})


let safariBuilder = SafariBuilder(build: {
    
    $0.title = "a"
    $0.urlArgs = ["b"]
    $0.action = "c"
    
})

let firefoxBuilder = FirefoxBuilder(build: {
    
    $0.title = "a"
    $0.iconUrl = "b"
    $0.timeToLive = 1.0
    $0.payload = ["c":["d":"e"]]
    
})

let chromeAppExtBuilder = ChromAppExtBuilder(build: {
    
    $0.collapseKey = "a"
    $0.delayWhileIdle = false
    $0.title = "b"
    $0.iconUrl = "c"
    $0.timeToLive = 1.0
    $0.payload = ["c":["d":"e"]]
    
    
})

let chromeBuilder = ChromeBuilder(build: {
    
    $0.title = "a"
    $0.iconUrl = "b"
    $0.timeToLive = 1.0
    $0.payload = ["c":["d":"e"]]
    
})



let safariExample = Notification.Settings.Safari(safariBuilder:safariBuilder)
let safariExampleJson = JSON(["title": "a", "urlArgs": ["b"], "action": "c"])

let firefoxExample = Notification.Settings.Firefox(firefoxBuilder:firefoxBuilder)
let firefoxExampleJson = JSON(["title": "a", "iconUrl": "b", "timeToLive": 1.0, "payload": ["c":["d":"e"]]])

let chromeAppExtExample = Notification.Settings.ChromAppExtension(chromeAppExtBuilder:chromeAppExtBuilder)
let chromeAppExtExampleJson = JSON(["collapseKey": "a", "delayWhileIdle": "false", "title": "b", "iconUrl": "c", "timeToLive": 1.0,"payload": ["c":["d":"e"]]])

let chromeExample = Notification.Settings.Chrome(chromeBuilder:chromeBuilder)
let chromeExampleJson = JSON(["title": "a", "iconUrl": "b", "timeToLive": 1.0,"payload": ["c":["d":"e"]]])

let gcmExample = Notification.Settings.Gcm(gcmBuilder:gcmBuilder)
let gcmExampleJson = JSON(["collapseKey": "a",  "interactiveCategory": "b", "delayWhileIdle": "false", "payload": ["c":["d":"e"]], "priority": "DEFAULT", "sound": "e", "timeToLive": 1.0, "icon": "g", "sync": "false", "visibility": "PUBLIC", "style": ["type": "BIGTEXT_NOTIFICATIION", "title" : "title", "url": "url", "text" : "text", "lines": ["lines"]], "lights":  ["ledArgb": "BLACK", "ledOnMs": 2, "ledOffMs": 2] ])

let apnsExample = Notification.Settings.Apns(apnsBuilder:apnsBuilder)

let apnsExampleJson = JSON(["badge": 0, "interactiveCategory": "a", "iosActionKey":"b", "sound": "c", "type": "DEFAULT", "payload": ["c": ["d": "e"]], "titleLocKey": "f", "locKey": "g", "launchImage": "h",
                            "titleLocArgs": ["i"], "locArgs": ["j"], "subtitle": "k", "title": "l", "attachmentUrl": "m"])

let targetBuilder = TargetBuilder(build: {
    
    $0.deviceIds = ["a"]
    $0.userIds =  ["u"]
    $0.platforms = [TargetPlatform.Apple, TargetPlatform.Google,TargetPlatform.WebChrome, TargetPlatform.WebFirefox, TargetPlatform.WebSafari, TargetPlatform.AppextChrome, ]
    $0.tagNames = ["c"]
    
})

let targetExample = Notification.Target(targetBuilder: targetBuilder)

let targetExampleJson = JSON(["deviceIds": ["a"], "userIds": ["u"], "platforms": ["A", "G", "WEB_CHROME", "WEB_FIREFOX", "WEB_SAFARI", "APPEXT_CHROME"], "tagNames": ["c"]])

let messageBuilder = MessageBuilder(build: {
    
    $0.alert = "a"
    $0.url =  "b"
    
})

let messageExample = Notification.Message(messageBuilder: messageBuilder)
let messageExampleJson = JSON(["alert": "a", "url": "b"])


let settingsBuilder = SettingsBuilder(build: {
    
    $0.apns = apnsExample
    $0.gcm = gcmExample
    $0.safari = safariExample
    $0.firefox = firefoxExample
    $0.chromeAppExtension = chromeAppExtExample
    $0.chrome = chromeExample
    
})

let settingsExample = Notification.Settings(settingsBuilder:settingsBuilder)

let notificatonBuilder = NotificationBuilder(build: {
    
    $0.message = messageExample;
    $0.target = targetExample;
    $0.settings = settingsExample;
})

let notificationExample = Notification(notificationBuilder:notificatonBuilder)

let notificationExampleJson = JSON(["message": messageExampleJson, "target": targetExampleJson, "settings": JSON(["apns": apnsExampleJson, "gcm": gcmExampleJson, "safariWeb": safariExampleJson, "firefoxWeb": firefoxExampleJson, "chromeAppExt": chromeAppExtExampleJson, "chromeWeb":chromeExampleJson])])

// MARK: - Linux requirement

extension BluemixPushNotificationsTests {
    static var allTests : [(String, (BluemixPushNotificationsTests) -> () throws -> Void)] {
        return [
            ("testPushNotificationsInitializer", testPushNotificationsInitializer),
            ("testApnsJsonFormatWithValues", testApnsJsonFormatWithValues),
            ("testGcmJsonFormatWithValues", testGcmJsonFormatWithValues),
            ("testMessageJsonFormatWithValues", testMessageJsonFormatWithValues),
            ("testTargetJsonFormatWithValues", testTargetJsonFormatWithValues),
            ("testNotificationJsonFormatWithValues", testNotificationJsonFormatWithValues),
            ("testNotificationJsonWithNil", testNotificationJsonWithNil),
            ("testMessageJsonWithNil", testMessageJsonWithNil),
            ("testTargetJsonWithNil", testTargetJsonWithNil),
            ("testApnsJsonFormatWithNil", testApnsJsonFormatWithNil),
            ("testGcmJsonFormatWithNil", testGcmJsonFormatWithNil),
        ]
    }
}
