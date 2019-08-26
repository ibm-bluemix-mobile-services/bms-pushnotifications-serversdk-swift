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


/**
    The Push notification to send. Includes the notification message, the targets to receive the message, and the APNS and GCM settings.
*/
public struct Notification {
    
    /// The content of the notification message.
    let message: Message
    
    /// Specifies the recipients of the notification.
    let target: Target?
    
    /// Additional properties that can be configured for the notification.
    let settings: Settings?
    
    // MARK: - Initializer
    
    /**
     The required intializer for the `Notification` class.
     
     - parameter message:           Message object.
     - parameter target:            (Optional)Target object.
     - parameter apnsSettings:      (Optional)APNs Settings object.
     - parameter gcmSettings:       (Optional)GCM Settings object.
     - parameter firefoxWebSettings:   (Optional)Firefox Settings object
     - parameter chromeWebSettings:    (Optional)Chrome Settings object
     - parameter safariWebSettings:    (Optional)Safari Settings object
     - parameter chromeAppExtSettings: (Optional)Chrome App/Extension Settings Object
     */
    public init(message: Message, target: Target? = nil, apnsSettings: Settings.Apns? = nil, gcmSettings: Settings.Gcm? = nil, firefoxWebSettings: Settings.FirefoxWeb? = nil, chromeWebSettings: Settings.ChromeWeb? = nil, safariWebSettings: Settings.SafariWeb? = nil, chromeAppExtSettings: Settings.ChromeAppExt? = nil) {
        
        self.message = message
        self.target = target
        self.settings = Settings.init(apns: apnsSettings, gcm: gcmSettings, firefoxWeb: firefoxWebSettings, chromeWeb: chromeWebSettings, safariWeb: safariWebSettings, chromeAppExt: chromeAppExtSettings)
    }
    
    
    internal var jsonFormat: [String:Any]? {
        
        var json: [String: Any] = [:]
        
        json["message"] = message.jsonFormat
        json["target"] = target?.jsonFormat
        json["settings"] = settings?.jsonFormat
        
        if !json.isEmpty {
            return json
        }
        else {
            return nil
        }
    }
    
    
    // MARK: -
    
    
    /**
     The content of the notification message.
     */
    public struct Message {
        
        /// The notification message to be shown to the user.
        let alert: String?
        
        /// An optional url to be sent along with the alert.
        let url: String?
        
        /**
         The required intializer for the `Message` class.
         
         - parameter alert:  Message text.
         - parameter url:  (Optional) URL for the message.
         */
        public init(alert: String?, url: String? = nil) {
            
            self.alert = alert
            self.url = url
        }
        
        
        internal var jsonFormat: [String: Any]? {
            
            var json: [String: Any] = [:]
            
            json["alert"] = alert
            json["url"] = url
            
            if !json.isEmpty {
                return json
            }
            else {
                return nil
            }
        }
    }
    
    
    // MARK: -
    
    
    /**
     Specifies the recipients of the notification.
     */
    public struct Target {
        
        /// The list of devices that will receive the notification.
        let deviceIds: [String]?
        
        /// The list of users that will receive the notification.
        let userIds: [String]?
        
        /// The plaforms that will receive the notification.
        let platforms: [TargetPlatform]?
        
        /// Devices subscribed to these tags will receive the notification.
        let tagNames: [String]?
        
        /**
         The required intializer for the `Target` class.
         
         - parameter deviceIds:    (Optional)Target DeviceIds as an array.
         - parameter userIds:      (Optional)Target userIds as an array.
         - parameter platforms:    (Optional)Target platforms as an array.
         - parameter tagNames:     (Optional)Target tagNames as an array.
         */
        public init(deviceIds: [String]? = nil, userIds: [String]? = nil, platforms: [TargetPlatform]? = nil, tagNames: [String]? = nil) {
            self.deviceIds = deviceIds
            self.userIds = userIds
            self.platforms = platforms
            self.tagNames = tagNames
        }
        
        
        internal var jsonFormat: [String: Any]? {
            
            var json: [String: Any] = [:]
            
            json["deviceIds"] = deviceIds
            
            json["userIds"] = userIds
            
            if let platformsAsStrings = platforms?.map({ $0.rawValue }) {
                json["platforms"] = !platformsAsStrings.isEmpty ? platformsAsStrings : nil
            }
            
            json["tagNames"] = tagNames
            
            if !json.isEmpty {
                return json
            }
            else {
                return nil
            }
        }
    }
    
    
    // MARK: -
    
    
    /**
     Additional properties that can be configured for the notification.
     */
    public struct Settings {
        
        /// Settings specific to the iOS platform.
        let apns: Apns?
        
        /// Settings specific to the Android platform.
        let gcm: Gcm?
        
        /// Settings specific to the firefoxWeb platform.
        let firefoxWeb: FirefoxWeb?
        
        /// Settings specific to the chromeWeb platform.
        let chromeWeb: ChromeWeb?
        
        /// Settings specific to the safariWeb platform.
        let safariWeb: SafariWeb?
        
        /// Settings specific to the chromeAppExt platform.
        let chromeAppExt: ChromeAppExt?
        
        
        internal init(apns: Apns? = nil, gcm: Gcm? = nil, firefoxWeb: FirefoxWeb? = nil, chromeWeb: ChromeWeb? = nil, safariWeb: SafariWeb? = nil, chromeAppExt: ChromeAppExt? = nil) {
            
            self.apns = apns
            self.gcm = gcm
            self.firefoxWeb = firefoxWeb
            self.chromeWeb = chromeWeb
            self.safariWeb = safariWeb
            self.chromeAppExt = chromeAppExt
        }
        
        
        internal var jsonFormat: [String: Any]? {
            
            var json: [String: Any] = [:]
            
            json["apns"] = apns?.jsonFormat
            json["gcm"] = gcm?.jsonFormat
            json["firefoxWeb"] = firefoxWeb?.jsonFormat
            json["chromeWeb"] = chromeWeb?.jsonFormat
            json["safariWeb"] = safariWeb?.jsonFormat
            json["chromeAppExt"] = chromeAppExt?.jsonFormat
            
            
            if !json.isEmpty {
                return json
            }
            else {
                return nil
            }
        }
        
        
        // MARK: -
        
        
        /**
         Settings specific to the iOS platform.
         */
        public struct Apns {
            
            /// The number to display as the badge of the application icon.
            let badge: Int?
            
            /// The category identifier to be used for interactive push notifications.
            let interactiveCategory: String?
            
            /// The title for the Action key.
            let iosActionKey: String?
            
            /// The name of the sound file in the application bunlde. The sound of this file is played as an alert.
            let sound: String?
            
            /// Determines whether an alert is shown or the message is placed in the notification center.
            let type: ApnsType?
            
            /// Custom JSON payload that will be sent as part of the notification message.
            let payload: [String: Any]?
            
            
            let titleLocKey: String?
            let locKey: String?
            let launchImage: String?
            let titleLocArgs: [String]?
            let locArgs: [String]?
            let title: String?
            let subtitle: String?
            let attachmentUrl: String?
            
            /**
             The required intializer for the `Apns` class.
             
             - parameter badge:    (Optional) APNs badge value.
             - parameter interactiveCategory:    (Optional) APNs interactiveCategory value.
             - parameter iosActionKey:    (Optional) APNs iosActionKey value.
             - parameter sound:    (Optional) APNs sound name.
             - parameter type:    (Optional) APNs Notifications type value.
             - parameter payload:    (Optional) APNs additional payload JSON.
             - parameter titleLocKey:    (Optional) APNs titleLocKey value.
             - parameter locKey:    (Optional) APNs locKey value.
             - parameter launchImage:    (Optional) APNs launchImage value.
             - parameter titleLocArgs:    (Optional) APNs titleLocArgs array.
             - parameter locArgs:    (Optional) APNs locArgs Array.
             - parameter title:    (Optional) APNs iOS 10 title value.
             - parameter subtitle:    (Optional) APNs iOS 10 subtitle value.
             - parameter attachmentUrl:    (Optional) APNs iOS 10 media url.
             
             */
            public init(badge: Int? = nil, interactiveCategory: String? = nil, iosActionKey: String? = nil, sound: String? = nil, type: ApnsType? = nil, payload: [String: Any]? = nil, titleLocKey: String? = nil, locKey: String? = nil, launchImage: String? = nil, titleLocArgs: [String]? = nil, locArgs: [String]? = nil, title: String? = nil, subtitle: String? = nil,  attachmentUrl: String? = nil) {
                
                self.badge = badge
                self.interactiveCategory = interactiveCategory
                self.iosActionKey = iosActionKey
                self.sound = sound
                self.type = type
                self.payload = payload
                
                self.titleLocKey = titleLocKey
                self.locKey = locKey
                self.launchImage = launchImage
                self.titleLocArgs = titleLocArgs
                self.locArgs = locArgs
                self.title = title
                self.subtitle = subtitle
                self.attachmentUrl = attachmentUrl
                
                
            }
            
            internal var jsonFormat: [String: Any]? {
                
                var json: [String: Any] = [:]
                
                json["badge"] = badge
                json["interactiveCategory"] = interactiveCategory
                json["iosActionKey"] = iosActionKey
                json["sound"] = sound
                json["type"] = type?.rawValue
                json["payload"] = payload
                
                json["titleLocKey"] = titleLocKey
                json["locKey"] = locKey
                json["launchImage"] = launchImage
                json["titleLocArgs"] = titleLocArgs
                json["locArgs"] = locArgs
                json["title"] = title
                json["subtitle"] = subtitle
                json["attachmentUrl"] = attachmentUrl
                
                if !json.isEmpty {
                    return json
                }
                else {
                    return nil
                }
            }
        }
        
        
        // MARK: -
        
        
        /**
         Settings specific to the Android platform.
         */
        public struct Gcm {
            
            /// Identifies a group of messages.
            let collapseKey: String?
            
            /// Indicates whether the message should not be sent until the device becomes active.
            let delayWhileIdle: Bool?
            
            /// Custom JSON payload that will be sent as part of the notification message.
            let payload: [String: Any]?
            
            /// The priority of the message.
            let priority: GcmPriority?
            
            /// The sound file (on device) that will be attempted to play when the notification arrives on the device.
            let sound: String?
            
            /// Specifies how long (in seconds) the message should be kept in GCM storage if the device is offline.
            let timeToLive: Double?
            
            /// The category identifier to be used for interactive push notifications.
            let interactiveCategory: String?
            
            /// The small notifications icon
            let icon: String?
            
            /// Device group messaging makes it possible for every app instance in a group to reflect the latest messaging state ,
            let sync: Bool?
            
            ///private/public - Visibility of this notification, which affects how and when the notifications are revealed on a secure locked screen.
            let visibility: GcmVisibility?
            
            //Allows setting the notification LED color on receiving push notification
            let lights: GcmLights?
            
            ///Options to specify for Android expandable notifications. The types of expandable notifications are picture_notification, bigtext_notification, inbox_notification
            let style: GcmStyle?
            
            /// Determines whether an alert is shown or the message is placed in the notification center.
            let type: FCMType?

            /// Android notification title
            let androidTitle: String?

            /**
             The required intializer for the `Gcm` class.
             
             - parameter collapseKey:    (Optional) GCM collapseKey value.
             - parameter delayWhileIdle:    (Optional) GCM delayWhileIdle value.
             - parameter payload:    (Optional) GCM payload Json.
             - parameter priority:    (Optional) GCM priority value.
             - parameter sound:    (Optional) GCM sound file name.
             - parameter timeToLive:    (Optional) GCM timeToLive value.
             - parameter interactiveCategory:    (Optional) GCM interactive actions Category value.
             - parameter icon:    (Optional) GCM icon file name.
             - parameter sync:    (Optional) GCM sync value.
             - parameter visibility:    (Optional) GcmVisibility object.
             - parameter lights:    (Optional) GcmLights object.
             - parameter style:    (Optional) GcmStyle object.
             - parameter type:    (Optional) FCMType object.
             - parameter androidTitle: (Optional) android Title.

             */
            public init(androidTitle:String? = nil, collapseKey: String? = nil, delayWhileIdle: Bool? = nil, payload: [String: Any]? = nil, priority: GcmPriority? = nil, sound: String? = nil, timeToLive: Double? = nil, interactiveCategory: String? = nil, icon: String? = nil,  sync: Bool? = nil, visibility: GcmVisibility? = nil, lights: GcmLights? = nil, style: GcmStyle? = nil, type: FCMType? = nil) {
                
                self.androidTitle = androidTitle
                self.collapseKey = collapseKey
                self.delayWhileIdle = delayWhileIdle
                self.payload = payload
                self.priority = priority
                self.sound = sound
                self.timeToLive = timeToLive
                self.interactiveCategory = interactiveCategory
                self.icon = icon
                self.sync = sync
                self.visibility = visibility
                self.lights = lights
                self.style = style
                self.type = type
            }
            
            
            internal var jsonFormat: [String: Any]? {
                var json: [String: Any] = [:]
                json["collapseKey"] = collapseKey
                json["androidTitle"] = androidTitle
                if let delay = delayWhileIdle {
                    json["delayWhileIdle"] = delay ? "true" : "false"
                }
                if let syncMessage = sync {
                    json["sync"] = syncMessage ? "true" : "false"
                }
                json["payload"] = payload
                json["priority"] = priority?.rawValue
                json["sound"] = sound
                json["timeToLive"] = timeToLive
                json["interactiveCategory"] = interactiveCategory
                json["icon"] = icon
                json["visibility"] = visibility
                json["lights"] = lights
                json["style"] = style
                json["type"] = type
                
                if !json.isEmpty {
                    return json
                }
                else {
                    return nil
                }
            }
        }
        
        public struct GcmLights {
            
            /// The color of the led. The hardware will do its best approximation.
            let ledArgb: GcmLED?
            
            /// The number of milliseconds for the LED to be on while it's flashing. The hardware will do its best approximation.
            let ledOnMs: Int?
            
            /// The number of milliseconds for the LED to be off while it's flashing. The hardware will do its best approximation.
            let ledOffMs: Int?
            
            /**
             The required intializer for the `GcmLights` class.
             
             - parameter ledArgb:   GcmLED string value.
             - parameter ledOnMs:   The number of milliseconds for the LED to be on while it's flashing. The hardware will do its best approximation.
             - parameter ledOffMs:  The number of milliseconds for the LED to be off while it's flashing. The hardware will do its best approximation.
             */
            public init(ledArgb: GcmLED?, ledOnMs: Int?, ledOffMs: Int?) {
                
                self.ledArgb = ledArgb
                self.ledOnMs = ledOnMs
                self.ledOffMs = ledOffMs
            }
            
            
            internal var jsonFormat: [String: Any]? {
                var json: [String: Any] = [:]
                
                json["ledArgb"] = ledArgb
                json["ledOnMs"] = ledOnMs
                json["ledOffMs"] = ledOffMs
                
                if !json.isEmpty {
                    return json
                }
                else {
                    return nil
                }
            }
            
        }
        public struct GcmStyle {
            
            /// Specifies the type of expandable notifications. The possible values are bigtext_notification, picture_notification, inbox_notification.
            let type: GcmStyleTypes?
            
            /// Specifies the title of the notification. The title is displayed when the notification is expanded. Title must be specified for all three expandable notification.
            let title: String?
            
            /// An URL from which the picture has to be obtained for the notification. Must be specified for picture_notification.
            let url: String?
            
            /// The big text that needs to be displayed on expanding a bigtext_notification. Must be specified for bigtext_notification.
            let text: String?
            
            /// An array of strings that is to be displayed in inbox style for inbox_notification. Must be specified for inbox_notification
            let lines: [String]?
            
            
            /**
             The required intializer for the `GcmStyle` class.
             
             - parameter type:     GcmStyleTypes object.
             - parameter title:    (Optional) title value.
             - parameter url:    (Optional) url value.
             - parameter text:    (Optional) text value.
             - parameter lines:    (Optional) lines array.
             
             */
            public init(type: GcmStyleTypes?, title: String? = nil, url: String? = nil, text: String? = nil, lines: [String]? = nil) {
                
                self.type = type
                self.title = title
                self.url = url
                self.text = text
                self.lines = lines
            }
            
            
            internal var jsonFormat: [String: Any]? {
                var json: [String: Any] = [:]
                
                json["type"] = type
                json["title"] = title
                json["url"] = url
                json["text"] = text
                json["lines"] = lines
                
                if !json.isEmpty {
                    return json
                }
                else {
                    return nil
                }
            }
            
        }
        
        
        /**
         Settings specific to the Firefox web platform.
         */
        public struct FirefoxWeb {
            
            /// Title for the notifications.
            let title: String?
            
            /// icon url for the notifications.
            let iconUrl: String?
            
            /// Custom JSON payload that will be sent as part of the notification message.
            let payload: [String: Any]?
            
            /// Specifies how long (in seconds) the message should be kept in GCM storage if the device is offline.
            let timeToLive: Double?
            
            /**
             The required intializer for the `FirefoxWeb` class.
             
             - parameter title:     title String.
             - parameter iconUrl:    (Optional) iconUrl value.
             - parameter payload:    (Optional) payload Json.
             - parameter timeToLive:    (Optional) timeToLive value.
             
             */
            public init(title: String?, iconUrl: String? = nil, payload: [String: Any]? = nil, timeToLive: Double? = nil) {
                
                self.payload = payload
                self.title = title
                self.iconUrl = iconUrl
                self.timeToLive = timeToLive
            }
            
            internal var jsonFormat: [String: Any]? {
                
                var json: [String: Any] = [:]
                json["payload"] = payload
                json["title"] = title
                json["iconUrl"] = iconUrl
                json["timeToLive"] = timeToLive
                
                if !json.isEmpty {
                    return json
                }
                else {
                    return nil
                }
            }
        }
        
        /**
         Settings specific to the Chrome web platform.
         */
        public struct ChromeWeb {
            
            /// Title for the notifications.
            let title: String?
            
            /// icon url for the notifications.
            let iconUrl: String?
            
            /// Custom JSON payload that will be sent as part of the notification message.
            let payload: [String: Any]?
            
            /// Specifies how long (in seconds) the message should be kept in GCM storage if the device is offline.
            let timeToLive: Double?
            
            /**
             The required intializer for the `ChromeWeb` class.
             
             - parameter title:     title String.
             - parameter iconUrl:    (Optional) iconUrl value.
             - parameter payload:    (Optional) payload Json.
             - parameter timeToLive:    (Optional) timeToLive value.
             
             */
            public init(title: String?, iconUrl: String? = nil, payload: [String: Any]? = nil, timeToLive: Double? = nil) {
                
                self.payload = payload
                self.title = title
                self.iconUrl = iconUrl
                self.timeToLive = timeToLive
            }
            
            internal var jsonFormat: [String: Any]? {
                
                var json: [String: Any] = [:]
                json["payload"] = payload
                json["title"] = title
                json["iconUrl"] = iconUrl
                json["timeToLive"] = timeToLive
                
                if !json.isEmpty {
                    return json
                }
                else {
                    return nil
                }
            }
        }
        
        /**
         Settings specific to the Safari platform.
         */
        public struct SafariWeb {
            
            /// Title for the notifications.
            let title: String?
            
            /// urlArgs for the notifications.
            let urlArgs: [String?]
            
            /// action name for the notifications.
            let action: String?
            
            /**
             The required intializer for the `SafariWeb` class.
             
             - parameter title:     title String.
             - parameter urlArgs:   urlArgs String array.
             - parameter action:    action String array.
             
             */
            public init(title: String?, urlArgs: [String?], action: String?) {
                
                self.title = title
                self.urlArgs = urlArgs
                self.action = action
            }
            
            internal var jsonFormat: [String: Any]? {
                
                var json: [String: Any] = [:]
                
                json["title"] = title
                json["urlArgs"] = urlArgs
                json["action"] = action
                
                if !json.isEmpty {
                    return json
                }
                else {
                    return nil
                }
            }
        }
        
        
        /**
         Settings specific to the Chrome apps and extensions platform.
         */
        public struct ChromeAppExt {
            
            /// Title for the notifications.
            let title: String?
            
            /// icon url for the notifications.
            let iconUrl: String?
            
            /// Identifies a group of messages.
            let collapseKey: String?
            
            /// Indicates whether the message should not be sent until the device becomes active.
            let delayWhileIdle: Bool?
            
            /// Custom JSON payload that will be sent as part of the notification message.
            let payload: [String: Any]?
            
            /// Specifies how long (in seconds) the message should be kept in GCM storage if the device is offline.
            let timeToLive: Double?
            
            /**
             The required intializer for the `ChromeAppExt` class.
             
             - parameter title:     title String.
             - parameter iconUrl:   (Optional)iconUrl String.
             - parameter collapseKey:    (Optional) collapseKey String.
             - parameter delayWhileIdle:    (Optional) delayWhileIdle value.
             - parameter payload:    (Optional) payload Json.
             - parameter timeToLive:    (Optional) timeToLive value.
             
             */
            public init(title: String?, iconUrl: String? = nil, collapseKey: String? = nil, delayWhileIdle: Bool? = false, payload: [String: Any]?  = nil, timeToLive: Double?  = nil) {
                
                self.collapseKey = collapseKey
                self.delayWhileIdle = delayWhileIdle
                self.payload = payload
                self.title = title
                self.iconUrl = iconUrl
                self.timeToLive = timeToLive
            }
            
            
            internal var jsonFormat: [String: Any]? {
                
                var json: [String: Any] = [:]
                
                json["collapseKey"] = collapseKey
                
                if let delay = delayWhileIdle {
                    json["delayWhileIdle"] = delay ? "true" : "false"
                }
                
                json["payload"] = payload
                json["title"] = title
                json["iconUrl"] = iconUrl
                json["timeToLive"] = timeToLive
                
                if !json.isEmpty {
                    return json
                }
                else {
                    return nil
                }
            }
        }
        
    }
}


/**
 The supported platforms for receiving push notifications.
 */
public enum TargetPlatform: String {
    
    case Apple = "A"
    case Google = "G"
    case WebChrome = "WEB_CHROME"
    case webFirefox = "WEB_FIREFOX"
    case WebSafari = "WEB_SAFARI"
    case ChromeExtApp = "APPEXT_CHROME"
}


/**
 Determines the visibility of the notifications
 */
public enum GcmVisibility: String {
    
    case Private
    case Public
}

/**
 Determines the GCM Style types
 */
public enum GcmStyleTypes: String {
    
    case picture_notification
    case bigtext_notification
    case inbox_notification
}

/**
 Determines the LED value in the notifications
 */
public enum GcmLED: String {
    
    case Black
    case DarkGray
    case Gray
    case LightGray
    case White
    case Red
    case Green
    case Blue
    case Yellow
    case Cyan
    case Magneta
    case Transparent
}

/**
 Determines whether an alert is shown or the message is placed in the notification center.
 */
public enum ApnsType: String {
    
    case DEFAULT
    case MIXED
    case SILENT
}

/**
 Determines whether an alert is shown or the message is placed in the notification center.
 */
public enum FCMType: String {
    
    case DEFAULT
    case SILENT
}

/**
 The available priorities of the notification message.
 */
public enum GcmPriority: String {
    
    case DEFAULT
    case MIN
    case LOW
    case HIGH
    case MAX
}
