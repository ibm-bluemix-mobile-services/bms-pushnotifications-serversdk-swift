# BluemixPushNotifications

[![Swift][swift-badge]][swift-url]
[![Platform][platform-badge]][platform-url]
[![Build Status](https://travis-ci.org/ibm-bluemix-mobile-services/bms-pushnotifications-serversdk-swift.svg?branch=master)](https://travis-ci.org/ibm-bluemix-mobile-services/bms-pushnotifications-serversdk-swift)
[![Build Status](https://travis-ci.org/ibm-bluemix-mobile-services/bms-pushnotifications-serversdk-swift.svg?branch=development)](https://travis-ci.org/ibm-bluemix-mobile-services/bms-pushnotifications-serversdk-swift)


## Summary

BluemixPushNotifications is a Swift server-side SDK for sending push notifications via Bluemix Push Notifications services.


## Installation

#### Swift Package Manager

```swift
import PackageDescription

let package = Package(
    dependencies: [
        .Package(url: "https://github.com/ibm-bluemix-mobile-services/bluemix-pushnotifications-swift-sdk.git", majorVersion: 0, minor: 1)
	]
)
```

**Note:** BluemixPushNotifications version 0.1.x only builds with Swift [DEVELOPMENT-SNAPSHOT-2016-05-03-a](https://swift.org/download/#snapshots)


#### Build on Linux

```bash
swift build -Xcc -fblocks -Xlinker -ldispatch
```

#### Build on OS X

```bash
swift build
```

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

Or create a more selective push notification with specified settings that only gets sent to certain devices.
```swift
let gcmExample = Notification.Settings.Gcm(collapseKey: "collapseKey", delayWhileIdle: true, payload: "payload", priority: GcmPriority.DEFAULT, sound: "sound.mp3", timeToLive: 1.0)
let apnsExample = Notification.Settings.Apns(badge: 1, category: "category", iosActionKey: "iosActionKey", sound: "sound.mp3", type: ApnsType.DEFAULT, payload: ["key": "value"])
let settingsExample = Notification.Settings(apns: apnsExample, gcm: gcmExample)
let targetExample = Notification.Target(deviceIds: ["device1", "device2"], platforms: [TargetPlatform.Apple, TargetPlatform.Google], tagNames: ["tag1", "tag2"])
let messageExample = Notification.Message(alert: "Testing BluemixPushNotifications", url: "url")

let notificationExample = Notification(message: messageExample, target: targetExample, settings: settingsExample)
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

Copyright 2016 IBM Corp.

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

