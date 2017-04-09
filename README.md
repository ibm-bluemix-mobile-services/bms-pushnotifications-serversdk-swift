# BluemixPushNotifications

[![Swift][swift-badge]][swift-url]
[![Platform][platform-badge]][platform-url]
[![Build Status](https://travis-ci.org/ibm-bluemix-mobile-services/bms-pushnotifications-serversdk-swift.svg)](https://travis-ci.org/ibm-bluemix-mobile-services/bms-pushnotifications-serversdk-swift)
[![Codacy Badge](https://api.codacy.com/project/badge/Grade/51d26cb37b4d474887087d455a311a43)](https://www.codacy.com/app/ibm-bluemix-mobile-services/bms-pushnotifications-serversdk-swift?utm_source=github.com&amp;utm_medium=referral&amp;utm_content=ibm-bluemix-mobile-services/bms-pushnotifications-serversdk-swift&amp;utm_campaign=Badge_Grade)
[![Coverage Status](https://coveralls.io/repos/github/ibm-bluemix-mobile-services/bms-pushnotifications-serversdk-swift/badge.svg?branch=development)](https://coveralls.io/github/ibm-bluemix-mobile-services/bms-pushnotifications-serversdk-swift?branch=development)

## Summary

BluemixPushNotifications is a Swift server-side SDK for sending push notifications via Bluemix Push Notifications services.

## Installation

#### Swift Package Manager

```swift
import PackageDescription

let package = Package(
    dependencies: [
        .Package(url: "https://github.com/ibm-bluemix-mobile-services/bluemix-pushnotifications-swift-sdk.git", majorVersion: 0, minor: 5)
	]
)
```

#### Build on Linux

```bash
sudo apt-get update // not required on Mac
swift build -Xcc -fblocks -Xlinker -rpath -Xlinker $(pwd)/.build/debug/
```

## Releases

* 0.5.x releases were tested on OSX and Linux with Swift 3.1
* 0.4.x releases were tested on OSX and Linux with Swift 3.0.1
* 0.4.x releases were tested on OSX and Linux with Swift DEVELOPMENT-SNAPSHOT-2016-09-07-a
* 0.3.x releases were tested on OSX and Linux with Swift DEVELOPMENT-SNAPSHOT-2016-06-20-a
* 0.2.x releases were tested on OSX and Linux with Swift DEVELOPMENT-SNAPSHOT-2016-06-06-a
* 0.1.x releases were tested on OSX and Linux with Swift DEVELOPMENT-SNAPSHOT-2016-05-03-a

## Usage

Import the BluemixPushNotifications framework.

```swift
import BluemixPushNotifications
```

Initialize with details about your Bluemix Push Notifications service.

```swift
let myPushNotifications = PushNotifications(bluemixRegion: PushNotifications.Region.US_SOUTH, bluemixAppGuid: "your-bluemix-app-guid", bluemixAppSecret: "your-push-service-appSecret")
```

Create a simple push notification that will broadcast to all devices using MessageBuilder.
```swift


let messageExample = Notification.Message(alert: "Testing BluemixPushNotifications", url: nil)// You can still use it, but will be removed in future releases.
or
let messageExample = Notification.Message(alert: "Testing BluemixPushNotifications")// No need to provide nil parameters.
 

// Using MessageBuilder. This is new approach.
let messageBuilder = MessageBuilder(build: {
    
    $0.alert = "Testing BluemixPushNotifications"
    $0.url =  "wwww.example.com"

})

let messageExample = Notification.Message(messageBuilder: messageBuilder) 

let notificationExample = Notification(message: messageExample, target: nil, apnsSettings: nil, gcmSettings: nil)// You can still use it will be removed in future.

// New signature shown below.
let notificationExample = Notification(message: messageExample, target: nil, settingsBuilder:nil)
or
let notificationExample = Notification(message: messageExample) // No need to provide nil parameters.


```

Or create a more selective push notification with specified settings that only gets sent to certain devices either by deviceIds or by userIds of users that own the devices or by device platforms or based on tag-subscriptions 
```swift
let gcmExample = Notification.Settings.Gcm(collapseKey: "collapseKey", delayWhileIdle: true, payload: ["key": "value"], priority: GcmPriority.DEFAULT, sound: "sound.wav", timeToLive: 1.0) // You can still use it, but will be removed in future releases.

//Note category is deprecated instead use interactiveCategory.

 let apnsExample = Notification.Settings.Apns(badge: 1, category: "category", iosActionKey: "iosActionKey", sound: "sound.wav", type: ApnsType.DEFAULT, payload: ["key": "value"])// You can still use it, but will be removed in future releases.
 
 or
 // Use interactiveCategory instead as shown below :

 let apnsExample = Notification.Settings.Apns(badge: 1, interactiveCategory: "interactiveCategory", iosActionKey: "iosActionKey", sound: "sound.wav", type: ApnsType.DEFAULT, payload: ["key": "value"]) // This will also removed in future release.
       
let targetExample = Notification.Target(deviceIds: ["device1", "device2"], userIds: ["userId1", "userId2"], platforms: [TargetPlatform.Apple, TargetPlatform.Google], tagNames: ["tag1", "tag2"]) // You can still use it, but will be removed in future releases.

// User TargetBuilder for construction.This is new approach.
// ** Note we should either provide deviceIds or userIds or platforms or tagNames.
let targetBuilder = TargetBuilder(build: {
    
    $0.deviceIds = ["deviceIds"]
    $0.userIds =  ["userIds"]
    $0.platforms = [TargetPlatform.Apple, TargetPlatform.Google,TargetPlatform.WebChrome, TargetPlatform.WebFirefox, TargetPlatform.WebSafari, TargetPlatform.AppextChrome, ]
    $0.tagNames = ["tagNames"]
    
})
let targetExample = Notification.Target(targetBuilder: targetBuilder)

let messageExample = Notification.Message(alert: "Testing BluemixPushNotifications", url: "url") // You can still use it, but will be removed in future releases.

// Use MessagBuilder for construction. This is new approach
let messageBuilder = MessageBuilder(build: {
    
    $0.alert = "alert"
    $0.url =  "www.example.com"

})
let messageExample = Notification.Message(messageBuilder: messageBuilder)

let notificationExample = Notification(message: messageExample, target: targetExample, apnsSettings: apnsExample, gcmSettings: gcmExample) // You can still use it, but will be removed in future releases.

//As per new approach we use SettingBuilder and set all or required optional settings (Firefox, Apns , Gcm etc) to it. You can set optional settings which are required, no need to set for all the settings, below is sample snippet

let settingsBuilder = SettingsBuilder(build: {
    

    // Use ApnsBuilder for construction, set only those members which you required and pass it as a parameter. Many new attributes added as shown below :
    
    $0.apns = Notification.Settings.Apns(apnsBuilder:ApnsBuilder(build: { // Passing  ApnsBuilder to set Apns Settings
        
        $0.badge = 0
        $0.interactiveCategory = "interactiveCategory"
        $0.iosActionKey = "iosActionKey"
        $0.sound = "sample.wav"
        $0.type = ApnsType.DEFAULT
        $0.titleLocKey = "titleLocKey"
        $0.locKey = "locKey"
        $0.launchImage = "launchImage"
        $0.titleLocArgs = ["titleLocArgs"]
        $0.locArgs = ["locArgs"]
        $0.subtitle = "subtitle"
        $0.title = "title"
        $0.attachmentUrl = "attachmentUrl"
    }))

    // Use GcmBuilder for construction, set only those members which you required and pass it as a parameter. Many new attributes added out of which style and lights attributes you need to construct as a json. usage in shown below :
    
    
    $0.gcm = Notification.Settings.Gcm(gcmBuilder:GcmBuilder(build: { // Passing GcmBuilder builder to set Gcm Settings.
        
        $0.collapseKey = "collapseKey"
        $0.delayWhileIdle = true
        $0.priority = GcmPriority.DEFAULT
        $0.sound = "sound.wav"
        $0.timeToLive = 1.0
        $0.icon = "iconUrl"
        $0.sync = false
        $0.visibility = Visibility.PUBLIC
        $0.style = Notification.Settings.GcmStyle(gcmStyleBuilder:GcmStyleBuilder(build: { // Contruction of style json using GcmStyleBuilder and passing it to GcmSyle.
            
            $0.type = GcmStyleTypes.INBOX_NOTIFICATION
            $0.title = "Style Messages"
            $0.url = "url"
            $0.text = "Text Message "
            $0.lines = ["firstLine"]
        })).jsonFormat
        $0.lights = Notification.Settings.GcmLights(gcmLightsBuilder: GcmLightsBuilder(build:{ // Construction of lights json using GcmLightsBuilder and passing it to GcmLights.
            
            $0.ledArgb = GcmLED.BLACK
            $0.ledOnMs = 2
            $0.ledOffMs = 2
            
        })).jsonFormat
    }))
    
    // New capabilities of optional settings Safari, Firefox, ChromeAppExtension and Chrome has been added
    
    // Safari (SafariBuilder). All the three settings needs to be set for Safari.
    
    $0.safari = Notification.Settings.Safari(safariBuilder:SafariBuilder(build: { // Passing SafariBuilder to set safari settings. All three settings need to be set for Safari.
        
        $0.title = "Safari"
        $0.urlArgs = ["urlArg1"]
        $0.action = "action"
        
    })
        
)
    // Firfox (FirefoxBuilder)

    $0.firefox = Notification.Settings.Firefox(firefoxBuilder: FirefoxBuilder(build: { // Passing FirefoxBuilder to set firefox settings
        
        $0.title = "firefox"
        $0.iconUrl = "iconurl"
        $0.timeToLive = 1.0
        
    })
)
    // ChromeAppExtension (ChromAppExtBuilder). Note : You should provide valid icon url or else notification would not work for ChromeAppExtension.

    $0.chromeAppExtension = Notification.Settings.ChromAppExtension(chromeAppExtBuilder:ChromAppExtBuilder(build: { // Passing ChromeAppExtBuilder to set chromeApp Settings
        
        $0.collapseKey = "collapseKey"
        $0.delayWhileIdle = false
        $0.title = "ChromeExt"
        $0.iconUrl = "iconUrl"
        $0.timeToLive = 1.0
        
        
    })
        
)
    // Chorme (ChromeBuilder)

    $0.chrome = Notification.Settings.Chrome(chromeBuilder:ChromeBuilder(build: { // Passing ChromeBuilder to set Chrome Settings
        
        $0.title = "Chrome"
        $0.iconUrl = "iconurl"
        $0.timeToLive = 1.0
        
        
    })
)

    
}) // pass it as a third parameter as shown below...

// New signature for Notification struct shown below.
let notificationExample = Notification(message: messageExample, target: targetExample, settingsBuilder:settingsBuilder)

```

Finally, send the Push notification.

```swift
myPushNotifications.send(notification: notificationExample) { (error) in
  if error != nil {
    print("Failed to send push notification. Error: \(error!)")
  }
}
```

## License

Copyright 2017 IBM Corp.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

[swift-badge]: https://img.shields.io/badge/Swift-3.0-orange.svg
[swift-url]: https://swift.org
[platform-badge]: https://img.shields.io/badge/Platforms-OS%20X%20--%20Linux-lightgray.svg
[platform-url]: https://swift.org
