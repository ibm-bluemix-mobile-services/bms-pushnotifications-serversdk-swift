/*
 *     Copyright 2017 IBM Corp.
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
import SwiftyJSON


/**
 Builder to build target object with deviceIds or userIds or platforms or tagNames.
*/
public class TargetBuilder {
    /// The list of devices that will receive the notification.
    var deviceIds: [String]?
    /// The list of users that will receive the notification.
    var userIds: [String]?
    /// The plaforms that will receive the notification.
    var platforms: [TargetPlatform]?
    /// Devices subscribed to these tags will receive the notification.
    var tagNames: [String]?
    typealias buildTargetClosure = (TargetBuilder) -> Void
    init(build:buildTargetClosure) {
        build(self)
    }
}

/**
 Builder to build optional settings for Gcm platform.
 */
public class GcmBuilder {
    /// Identifies a group of messages.
    var collapseKey: String?
    /// The interactiveCategory identifier to be used for interactive push notifications.
    var interactiveCategory: String?
    /// Indicates whether the message should not be sent until the device becomes active.
    var delayWhileIdle: Bool?
    /// Custom JSON payload that will be sent as part of the notification message.
    var payload: [String: Any]?
    /// The priority of the message.
    var priority: GcmPriority?
    /// The sound file (on device) that will be attempted to play when the notification arrives on the device.
    var sound: String?
    /// Specifies how long (in seconds) the message should be kept in GCM storage if the device is offline.
    var timeToLive: Double?
   /// Specify the name of the icon to be displayed for the notification. Make sure the icon is already packaged with the client application.
    var icon: String?
    /// device group messaging makes it possible for every app instance in a group to reflect the latest messaging state.
    var sync: Bool?
    /// private/public - Visibility of this notification, which affects how and when the notifications are revealed on a secure locked screen.
    var visibility: Visibility?
    /// Options to specify for Android expandable notifications. The types of expandable notifications are picture_notification, bigtext_notification, inbox_notification
    var style: [String: Any]?
    /// Allows setting the notification LED color on receiving push notification.
    var lights: [String: Any]?
    typealias buildGcmClosure = (GcmBuilder) -> Void
      init(build:buildGcmClosure) {
        build(self)
    }
}

/**
 Builder to build optional settings for Apns platform.
 */
public class ApnsBuilder {
    /// The number to display as the badge of the application icon.
    var badge: Int?
    /// The interactiveCategory identifier to be used for interactive push notifications.
    var category: String?
    /// The interactiveCategory identifier to be used for interactive push notifications.
    var interactiveCategory: String?
    /// The title for the Action key.
    var iosActionKey: String?
    /// The name of the sound file in the application bunlde. The sound of this file is played as an alert.
    var sound: String?
    /// Determines whether an alert is shown or the message is placed in the notification center.
    var type: ApnsType?
    /// Custom JSON payload that will be sent as part of the notification message.
    var payload: [String: Any]?
    /// The key to a title string in the Localizable.strings file for the current localization. The key string can be formatted with %@ and %n$@ specifiers to take the variables specified in the titleLocArgs array.
    var titleLocKey: String?
    /// A key to an alert-message string in a Localizable.strings file for the current localization (which is set by the user’s language preference). The key string can be formatted with %@ and %n$@ specifiers to take the variables specified in the locArgs array.
    var locKey: String?
     /// The filename of an image file in the app bundle, with or without the filename extension. The image is used as the launch image when users tap the action button or move the action slider.
    var launchImage: String?
    /// Variable string values to appear in place of the format specifiers in title-loc-key.
    var titleLocArgs: [String]?
    /// Variable string values to appear in place of the format specifiers in locKey
    var locArgs: [String]?
    /// The subtitle of the Rich Notifications. (Supported only on iOS 10 and above).
    var subtitle: String?
    /// The title of Rich Push notifications (Supported only on iOS 10 and above).
    var title: String?
    // The link to the iOS notifications media (video, audio, GIF, images - Supported only on iOS 10 and above).
    var attachmentUrl: String?
    typealias buildApnsClosure = (ApnsBuilder) -> Void
    init(build:buildApnsClosure) {
        build(self)
    }
}

/**
 Builder to build optional settings for Safari platform.
 */
public class SafariBuilder {
    /// Specifies the title to be set for the Safari Push Notifications.
    var title: String?
    /// The URL arguments that need to be used with this notification. This has to provided in the form of a JSON Array.
    var urlArgs: [String]?
    /// The label of the action button.
    var action: String?
    typealias buildSafariClosure = (SafariBuilder) -> Void
    init(build:buildSafariClosure) {
        build(self)
    }
}

/**
 Builder to build optional settings for Firefox platform.
 */
public class FirefoxBuilder {
    /// Specifies the title to be set for the WebPush Notification.
    var title: String?
    /// The URL of the icon to be set for the WebPush Notification
    var iconUrl: String?
    /// This parameter specifies how long (in seconds) the message should be kept in GCM storage if the device is offline.
    var timeToLive: Double?
    /// Custom JSON payload that will be sent as part of the notification message.
    var payload: [String: Any]?
    typealias buildFirefoxClosure = (FirefoxBuilder) -> Void
    init(build:buildFirefoxClosure) {
        build(self)
    }
}

/**
 Builder to build optional settings for ChromeAppExtension platform.
 */
public class ChromAppExtBuilder {
    /// This parameter identifies a group of messages
    var collapseKey: String?
    /// When this parameter is set to true, it indicates that the message should not be sent until the device becomes active.
    var delayWhileIdle: Bool?
    /// Specifies the title to be set for the WebPush Notification.
    var title: String?
    /// The URL of the icon to be set for the WebPush Notification.If you set icon url then you should provide a valide icon url or else notification would not work for chromeAppExt.
    var iconUrl: String?
    /// This parameter specifies how long (in seconds) the message should be kept in GCM storage if the device is offline.
    var timeToLive: Double?
    /// Custom JSON payload that will be sent as part of the notification message.
    var payload: [String: Any]?
    typealias buildChromeAppExtClosure = (ChromAppExtBuilder) -> Void
    init(build:buildChromeAppExtClosure) {
        build(self)
    }

}

/**
 Builder to build optional settings for Chrome platform.
 */
public class ChromeBuilder {
    /// Specifies the title to be set for the WebPush Notification.
    var title: String?
    /// The URL of the icon to be set for the WebPush Notification
    var iconUrl: String?
    /// This parameter specifies how long (in seconds) the message should be kept in GCM storage if the device is offline.
    var timeToLive: Double?
    /// Custom JSON payload that will be sent as part of the notification message.
    var payload: [String: Any]?
    typealias buildChromeClosure = (ChromeBuilder) -> Void
    init(build:buildChromeClosure) {
        build(self)
    }
}

/**
 Builder to build Message with alert and url attributes.
 */
public class MessageBuilder {
    /// The notification message to be shown to the user.
    var alert: String?
    /// An optional url to be sent along with the alert.
    var url: String?
    typealias buildMessageClosure = (MessageBuilder) -> Void
    init(build:buildMessageClosure) {
        build(self)
    }
}

/**
 Builder to build GcmLights.
 */

public class GcmLightsBuilder {
    /// The color of the led. The hardware will do its best approximation.
    var ledArgb: GcmLED?
    /// The number of milliseconds for the LED to be on while it's flashing. The hardware will do its best approximation.
    var ledOnMs: Int?
    /// The number of milliseconds for the LED to be off while it's flashing. The hardware will do its best approximation.
    var ledOffMs: Int?
    typealias buildLightsClosure = (GcmLightsBuilder) -> Void
    init(build:buildLightsClosure) {
        build(self)
    }
}

/**
 Builder to build GcmStyle.
 */
public class GcmStyleBuilder {
    /// Specifies the type of expandable notifications. The possible values are bigtext_notification, picture_notification, inbox_notification.
    var type: GcmStyleTypes?
    /// Specifies the title of the notification. The title is displayed when the notification is expanded. Title must be specified for all three expandable notification.
    var title: String?
    /// An URL from which the picture has to be obtained for the notification. Must be specified for picture_notification.
    var url: String?
    /// The big text that needs to be displayed on expanding a bigtext_notification. Must be specified for bigtext_notification.
    var text: String?
    /// An array of strings that is to be displayed in inbox style for inbox_notification. Must be specified for inbox_notification.
    var lines: [String]?
    typealias buildStyleClosure = (GcmStyleBuilder) -> Void
    init(build:buildStyleClosure) {
        build(self)
    }
}

/**
 Builder to build settings object with all the platform optional settings.
 */
public class SettingsBuilder {
    /// Settings specific to the iOS platform.
    var apns: Notification.Settings.Apns?
    /// Settings specific to the Android platform.
    var gcm: Notification.Settings.Gcm?
    /// Settings sepecific to SafariWeb browser.
    var safari: Notification.Settings.Safari?
    /// Settings sepecific to FirefoxWeb browser.
    var firefox: Notification.Settings.Firefox?
    /// Settings sepecific to ChromeAppExtension.
    var chromeAppExtension: Notification.Settings.ChromAppExtension?
    /// Settings sepecific to ChromeWeb browser.
    var chrome: Notification.Settings.Chrome?
    typealias buildSettingsClosure = (SettingsBuilder) -> Void
    init(build:buildSettingsClosure) {
        build(self)
    }
}

/**
 Builder to build final notification object with message, target and settings.
 */
public class NotificationBuilder {
    /// The content of the notification message.
    var message: Notification.Message?
    /// Specifies the recipients of the notification.
    var target: Notification.Target?
    /// Additional properties that can be configured for the notification.
    var settings: Notification.Settings?
    typealias buildNotificationClosure = (NotificationBuilder) -> Void
    init(build:buildNotificationClosure) {
        build(self)
    }
}
