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
import SwiftyJSON


/**
    The Push notification to send. Includes the notification message, the targets to receive the message, and the APNS and GCM settings.
*/
public struct Notification {

    /// The content of the notification message.
    public let message: Message

    /// Specifies the recipients of the notification.
    public let target: Target?

    /// Additional properties that can be configured for the notification.
    public let settings: Settings?


    public init(message: Message, target: Target?=nil, settings: Settings?=nil ) {

        self.message = message
        self.target = target
        self.settings = settings
}

    internal var jsonFormat: JSON? {

        var json: [String: JSON] = [:]
      
        json["message"] = message.jsonFormat
        json["target"] = target?.jsonFormat
        json["settings"] = settings?.jsonFormat
        
        if !json.isEmpty {
            return JSON(json)
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

        public init(messageBuilder: MessageBuilder?) {
            
                self.alert = messageBuilder?.alert
                self.url = messageBuilder?.url
            
        }

        internal var jsonFormat: JSON? {

			var json: [String: Any] = [:]

            json["alert"] = alert
            json["url"] = url

            if !json.isEmpty {
                return JSON(json)
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
        
        public init(targetBuilder: TargetBuilder?) {
          
                self.deviceIds = targetBuilder?.deviceIds
                self.userIds = targetBuilder?.userIds
                self.platforms = targetBuilder?.platforms
                self.tagNames = targetBuilder?.tagNames
            
        }

        internal var jsonFormat: JSON? {

            var json: [String: Any] = [:]

            json["deviceIds"] = deviceIds
            json["userIds"] = userIds

			if let platformsAsStrings = platforms?.map({ $0.rawValue }) {
				json["platforms"] = !platformsAsStrings.isEmpty ? platformsAsStrings : nil
			}

            json["tagNames"] = tagNames

            if !json.isEmpty {
                return JSON(json)
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
        
        /// Settings sepecific to SafariWeb browser.
        let safari: Safari?
        
        /// Settings sepecific to FirefoxWeb browser.
        let firefox: Firefox?
        
        /// Settings sepecific to ChromeAppExtension.
        let chromeAppExtension: ChromAppExtension?
        
        /// Settings sepecific to ChromeWeb browser.
        let chrome: Chrome?
        
        internal init(settingsBuilder: SettingsBuilder?) {

                self.apns = settingsBuilder?.apns
                self.gcm = settingsBuilder?.gcm
                self.safari = settingsBuilder?.safari
                self.firefox = settingsBuilder?.firefox
                self.chromeAppExtension = settingsBuilder?.chromeAppExtension
                self.chrome = settingsBuilder?.chrome
        }


        internal var jsonFormat: JSON? {

            var json: [String: JSON] = [:]

            json["apns"] = apns?.jsonFormat
            json["gcm"] = gcm?.jsonFormat
            json["safariWeb"] = safari?.jsonFormat
            json["firefoxWeb"] = firefox?.jsonFormat
            json["chromeAppExt"] = chromeAppExtension?.jsonFormat
            json["chromeWeb"] = chrome?.jsonFormat
            
            if !json.isEmpty {
                return JSON(json)
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
            
            /// The interactiveCategory identifier to be used for interactive push notifications.
            let category: String?
            
            /// The interactiveCategory identifier to be used for interactive push notifications.
            let interactiveCategory: String?
            
            /// The title for the Action key.
            let iosActionKey: String?
            
            /// The name of the sound file in the application bunlde. The sound of this file is played as an alert.
            let sound: String?
            
            /// Determines whether an alert is shown or the message is placed in the notification center.
            let type: ApnsType?
            
            /// Custom JSON payload that will be sent as part of the notification message.
            let payload: [String: Any]?
            
            /// The key to a title string in the Localizable.strings file for the current localization. The key string can be formatted with %@ and %n$@ specifiers to take the variables specified in the titleLocArgs array.
            let titleLocKey: String?
            
            /// A key to an alert-message string in a Localizable.strings file for the current localization (which is set by the user’s language preference). The key string can be formatted with %@ and %n$@ specifiers to take the variables specified in the locArgs array.
            let locKey: String?
            
            /// The filename of an image file in the app bundle, with or without the filename extension. The image is used as the launch image when users tap the action button or move the action slider.
            let launchImage: String?
            
            /// Variable string values to appear in place of the format specifiers in title-loc-key.
            let titleLocArgs: [String]?
            
            /// Variable string values to appear in place of the format specifiers in locKey.
            let locArgs: [String]?
            
            /// The title of Rich Push notifications (Supported only on iOS 10 and above).
            let title: String?
            
            /// The subtitle of the Rich Notifications. (Supported only on iOS 10 and above).
            let subtitle: String?
            
            /// The link to the iOS notifications media (video, audio, GIF, images - Supported only on iOS 10 and above).
            let attachmentUrl: String?
            
            public init(apnsBuilder: ApnsBuilder?) {
               
                self.badge = apnsBuilder?.badge
                self.category = apnsBuilder?.category
                self.interactiveCategory = apnsBuilder?.interactiveCategory
                self.iosActionKey = apnsBuilder?.iosActionKey
                self.sound = apnsBuilder?.sound
                self.type = apnsBuilder?.type
                self.payload = apnsBuilder?.payload
                self.titleLocKey = apnsBuilder?.titleLocKey
                self.locKey = apnsBuilder?.locKey
                self.launchImage = apnsBuilder?.launchImage
                self.titleLocArgs = apnsBuilder?.titleLocArgs
                self.locArgs = apnsBuilder?.locArgs
                self.subtitle = apnsBuilder?.subtitle
                self.title = apnsBuilder?.title
                self.attachmentUrl = apnsBuilder?.attachmentUrl
               
            }
            
            internal var jsonFormat: JSON? {
                
                var json: [String: Any] = [:]
                
                json["badge"] = badge
                json["category"] = category
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
                json["subtitle"] = subtitle
                json["title"] = title
                json["attachmentUrl"] = attachmentUrl
                
                if !json.isEmpty {
                    return JSON(json)
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
            
            /// The interactiveCategory identifier to be used for interactive push notifications.
            let interactiveCategory: String?

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
            
            /// Specify the name of the icon to be displayed for the notification. Make sure the icon is already packaged with the client application.
            let icon: String?
            
            /// evice group messaging makes it possible for every app instance in a group to reflect the latest messaging state.
            let sync: Bool?
            
            /// private/public - Visibility of this notification, which affects how and when the notifications are revealed on a secure locked screen.
            let visibility: Visibility?
            
            /// Options to specify for Android expandable notifications. The types of expandable notifications are picture_notification, bigtext_notification, inbox_notification
            let style: [String: Any]?
            
            /// Allows setting the notification LED color on receiving push notification.
            let lights: [String: Any]?
            
            public init(gcmBuilder:GcmBuilder?) {
                
                self.collapseKey = gcmBuilder?.collapseKey
                self.interactiveCategory = gcmBuilder?.interactiveCategory
                self.delayWhileIdle = gcmBuilder?.delayWhileIdle
                self.payload = gcmBuilder?.payload
                self.priority = gcmBuilder?.priority
                self.sound = gcmBuilder?.sound
                self.timeToLive = gcmBuilder?.timeToLive
                self.icon = gcmBuilder?.icon
                self.sync = gcmBuilder?.sync
                self.visibility=gcmBuilder?.visibility
                self.style = gcmBuilder?.style
                self.lights = gcmBuilder?.lights
                
            }


            internal var jsonFormat: JSON? {

                var json: [String: Any] = [:]

                json["collapseKey"] = collapseKey
                json["interactiveCategory"] = interactiveCategory

                if let delay = delayWhileIdle {
                    json["delayWhileIdle"] = delay ? "true" : "false"
                }
                json["payload"] = payload
                json["priority"] = priority?.rawValue
                json["sound"] = sound
                json["timeToLive"] = timeToLive
                json["icon"] = icon
                if let synchronize = sync {
                    json["sync"] = synchronize ? "true" : "false"
                }
                json["visibility"] = visibility?.rawValue
                json["style"] = style
                json["lights"] = lights
                if !json.isEmpty {
                    return JSON(json)
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
        
            public init(gcmLightsBuilder: GcmLightsBuilder?) {
                
                self.ledArgb = gcmLightsBuilder?.ledArgb
                self.ledOnMs = gcmLightsBuilder?.ledOnMs
                self.ledOffMs = gcmLightsBuilder?.ledOffMs
                
            }
            
            internal var jsonFormat: [String: Any]? {
                
                var json: [String: Any] = [:]
                
                json["ledArgb"] = ledArgb?.rawValue
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
            
            
            public init(gcmStyleBuilder: GcmStyleBuilder?) {
                
                self.type = gcmStyleBuilder?.type
                self.title = gcmStyleBuilder?.title
                self.url = gcmStyleBuilder?.url
                self.text = gcmStyleBuilder?.text
                self.lines = gcmStyleBuilder?.lines
                
            }
            
            internal var jsonFormat: [String: Any]? {
                
                var json: [String: Any] = [:]
                
                json["type"] = type?.rawValue
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
        
        // MARK: -
        
        /**
         Settings specific to the SafariWeb browser.
         */
        public struct Safari {
            
            /// Specifies the title to be set for the Safari Push Notifications
            let title: String?
           
            /// The URL arguments that need to be used with this notification. This has to provided in the form of a JSON Array.
            let urlArgs: [String]?
            
            /// The label of the action button
            let action: String?
            
            public init(safariBuilder: SafariBuilder?) {
                
                self.title = safariBuilder?.title
                self.urlArgs = safariBuilder?.urlArgs
                self.action = safariBuilder?.action
                
            }
            
            internal var jsonFormat: JSON? {
                
                var json: [String: Any] = [:]
                
                json["title"] = title
                json["urlArgs"] = urlArgs
                json["action"] = action
                
                if !json.isEmpty {
                    return JSON(json)
                }
                else {
                    return nil
                }
            }
        }
        
        // MARK: -
        
        /**
         Settings specific to the FirefoxWeb browser.
         */
        public struct Firefox {
        
            /// Specifies the title to be set for the WebPush Notification.
            let title: String?
         
            /// The URL of the icon to be set for the WebPush Notification
            let iconUrl: String?
            
            /// his parameter specifies how long (in seconds) the message should be kept in GCM storage if the device is offline.
            let timeToLive: Double?
            
            /// Custom JSON payload that will be sent as part of the notification message.
            let payload: [String: Any]?
            
            public init(firefoxBuilder: FirefoxBuilder?) {
                
                self.title = firefoxBuilder?.title
                self.iconUrl = firefoxBuilder?.iconUrl
                self.timeToLive = firefoxBuilder?.timeToLive
                self.payload = firefoxBuilder?.payload
                
            }
            
            
            internal var jsonFormat: JSON? {
                
                var json: [String: Any] = [:]
                
                json["title"] = title
                json["iconUrl"] = iconUrl
                json["timeToLive"] = timeToLive
                json["payload"] = payload
                
                if !json.isEmpty {
                    return JSON(json)
                }
                else {
                    return nil
                }
            }
        }
        
        // MARK: -
        
        /**
         Settings specific to the ChromeAppExtension platform.
         */
        public struct ChromAppExtension {
            
            /// This parameter identifies a group of messages
            let collapseKey: String?
           
            /// When this parameter is set to true, it indicates that the message should not be sent until the device becomes active.
            let delayWhileIdle: Bool?
            
            /// Specifies the title to be set for the WebPush Notification.
            let title: String?
            
            /// The URL of the icon to be set for the WebPush Notification.If you set icon url then you should provide a valide icon url or else notification would not work for chromeAppExt.
            let iconUrl: String?
            
            /// This parameter specifies how long (in seconds) the message should be kept in GCM storage if the device is offline.
            let timeToLive: Double?
            
            /// Custom JSON payload that will be sent as part of the notification message.
            let payload: [String: Any]?
            
            public init(chromeAppExtBuilder: ChromAppExtBuilder?) {
                
                self.collapseKey = chromeAppExtBuilder?.collapseKey
                self.delayWhileIdle = chromeAppExtBuilder?.delayWhileIdle
                self.title =  chromeAppExtBuilder?.title
                self.iconUrl = chromeAppExtBuilder?.iconUrl
                self.timeToLive = chromeAppExtBuilder?.timeToLive
                self.payload = chromeAppExtBuilder?.payload
                
            }
            
            
            internal var jsonFormat: JSON? {
                
                var json: [String: Any] = [:]
                
                json["collapseKey"] = collapseKey
                if let delay = delayWhileIdle {
                    json["delayWhileIdle"] = delay ? "true" : "false"
                }
                json["title"] = title
                json["iconUrl"] = iconUrl
                json["timeToLive"] = timeToLive
                json["payload"] = payload
                
                if !json.isEmpty {
                    return JSON(json)
                }
                else {
                    return nil
                }
            }
        }
        
         // MARK: -
        
        /**
         Settings specific to the ChromWeb browser.
         */
        public struct Chrome {
            
            /// Specifies the title to be set for the WebPush Notification.
            let title: String?
            
            /// The URL of the icon to be set for the WebPush Notification
            let iconUrl: String?
            
            /// This parameter specifies how long (in seconds) the message should be kept in GCM storage if the device is offline.
            let timeToLive: Double?
            
            /// Custom JSON payload that will be sent as part of the notification message.
            let payload: [String: Any]?
            
            public init(chromeBuilder: ChromeBuilder?) {
                
                self.title = chromeBuilder?.title
                self.iconUrl = chromeBuilder?.iconUrl
                self.timeToLive = chromeBuilder?.timeToLive
                self.payload = chromeBuilder?.payload
                
            }
            
            internal var jsonFormat: JSON? {
                
                var json: [String: Any] = [:]
                
                json["title"] = title
                json["iconUrl"] = iconUrl
                json["timeToLive"] = timeToLive
                json["payload"] = payload
                
                if !json.isEmpty {
                    return JSON(json)
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
    case WebFirefox = "WEB_FIREFOX"
    case WebSafari = "WEB_SAFARI"
    case AppextChrome = "APPEXT_CHROME"
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
    The available priorities of the notification message.
*/
public enum GcmPriority: String {

    case DEFAULT
    case MIN
    case LOW
    case HIGH
    case MAX
}

/**
 The available style type of the gcm notification message.
 */
public enum GcmStyleTypes: String {
    
    case BIGTEXT_NOTIFICATIION
    case INBOX_NOTIFICATION
    case PICTURE_NOTIFICATION
}

/**
 
 Determines the LED value in the notifications
 
 */

public enum GcmLED: String {
    
    case BLACK
    case DARKGRAY
    case GRAY
    case LightGray
    case WHITE
    case RED
    case GREEN
    case BLUE
    case YELLOW
    case CYAN
    case MAGENTA
    case TRANSPARENT
    
}
/**
 The available visibility of the notification message.
 */
public enum Visibility: String {
    
    case PUBLIC
    case PRIVATE
    case SECRET
}
