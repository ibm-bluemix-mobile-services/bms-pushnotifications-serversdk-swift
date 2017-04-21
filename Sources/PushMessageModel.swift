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
    var deviceIds: [String]?
    var userIds: [String]?
    var platforms: [TargetPlatform]?
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
    var collapseKey: String?
    var interactiveCategory: String?
    var delayWhileIdle: Bool?
    var payload: [String: Any]?
    var priority: GcmPriority?
    var sound: String?
    var timeToLive: Double?
    var icon: String?
    var sync: Bool?
    var visibility: Visibility?
    var style: [String: Any]?
    var lights: [String: Any]?
    var gcmStyleBuilder: GcmStyleBuilder?
    var gcmLightsBuilder: GcmLightsBuilder?
    typealias buildGcmClosure = (GcmBuilder) -> Void
      init(build:buildGcmClosure) {
        build(self)
    }
}

/**
 Builder to build optional settings for Apns platform.
 */
public class ApnsBuilder {
    var badge: Int?
    var category: String?
    var interactiveCategory: String?
    var iosActionKey: String?
    var sound: String?
    var type: ApnsType?
    var payload: [String: Any]?
    var titleLocKey: String?
    var locKey: String?
    var launchImage: String?
    var titleLocArgs: [String]?
    var locArgs: [String]?
    var subtitle: String?
    var title: String?
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
    var title: String?
    var urlArgs: [String]?
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
    var title: String?
    var iconUrl: String?
    var timeToLive: Double?
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
    var collapseKey: String?
    var delayWhileIdle: Bool?
    var title: String?
    var iconUrl: String?
    var timeToLive: Double?
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
    var title: String?
    var iconUrl: String?
    var timeToLive: Double?
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
    var alert: String?
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
    var ledArgb: GcmLED?
    var ledOnMs: Int?
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
    var type: GcmStyleTypes?
    var title: String?
    var url: String?
    var text: String?
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
    var apns: Notification.Settings.Apns?
    var gcm: Notification.Settings.Gcm?
    var safari: Notification.Settings.Safari?
    var firefox: Notification.Settings.Firefox?
    var chromeAppExtension: Notification.Settings.ChromAppExtension?
    var chrome: Notification.Settings.Chrome?
    typealias buildSettingsClosure = (SettingsBuilder) -> Void
    init(build:buildSettingsClosure) {
        build(self)
    }
}
