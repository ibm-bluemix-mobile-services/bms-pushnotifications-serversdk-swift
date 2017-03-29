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

Create a simple push notification that will broadcast to all devices.
```swift
let messageExample = Notification.Message(alert: "Testing BluemixPushNotifications", url: nil)
let notificationExample = Notification(message: messageExample, target: nil, settings: nil)
```

Or create a more selective push notification with specified settings that only gets sent to certain devices either by deviceIds or by userIds of users that own the devices or by device platforms or based on tag-subscriptions
```swift
let gcmExample = Notification.Settings.Gcm(collapseKey: "collapseKey", delayWhileIdle: true, payload: "payload", priority: GcmPriority.DEFAULT, sound: "sound.mp3", timeToLive: 1.0)
let apnsExample = Notification.Settings.Apns(badge: 1, category: "category", iosActionKey: "iosActionKey", sound: "sound.mp3", type: ApnsType.DEFAULT, payload: ["key": "value"])
let targetExample = Notification.Target(deviceIds: ["device1", "device2"], userIds: ["userId1", "userId2"], platforms: [TargetPlatform.Apple, TargetPlatform.Google], tagNames: ["tag1", "tag2"])
let messageExample = Notification.Message(alert: "Testing BluemixPushNotifications", url: "url")

let notificationExample = Notification(message: messageExample, target: targetExample, apnsSettings: apnsExample, gcmSettings: gcmExample)
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
