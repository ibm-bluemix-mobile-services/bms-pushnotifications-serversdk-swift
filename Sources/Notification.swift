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


    public init(message: Message, target: Target?, apnsSettings: Settings.Apns?, gcmSettings: Settings.Gcm?) {

        self.message = message
        self.target = target
        self.settings = Settings(apns: apnsSettings, gcm: gcmSettings)
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

        public init(alert: String?, url: String?) {

            self.alert = alert
            self.url = url
        }


        internal var jsonFormat: JSON? {

            #if os(Linux)
                var json: [String: Any] = [:]
            #else
                var json: [String: AnyObject] = [:]
            #endif

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

        /// The plaforms that will receive the notification.
        let platforms: [TargetPlatform]?

        /// Devices subscribed to these tags will receive the notification.
        let tagNames: [String]?

        public init(deviceIds: [String]?, platforms: [TargetPlatform]?, tagNames: [String]?) {
            self.deviceIds = deviceIds
            self.platforms = platforms
            self.tagNames = tagNames
        }


        internal var jsonFormat: JSON? {

            #if os(Linux)
                var json: [String: Any] = [:]
            #else
                var json: [String: AnyObject] = [:]
            #endif

            json["deviceIds"] = deviceIds

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

        private init(apns: Apns?, gcm: Gcm?) {

            self.apns = apns
            self.gcm = gcm
        }


        internal var jsonFormat: JSON? {

            var json: [String: JSON] = [:]

            json["apns"] = apns?.jsonFormat
            json["gcm"] = gcm?.jsonFormat

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

            /// The category identifier to be used for interactive push notifications.
            let category: String?

            /// The title for the Action key.
            let iosActionKey: String?

            /// The name of the sound file in the application bunlde. The sound of this file is played as an alert.
            let sound: String?

            /// Determines whether an alert is shown or the message is placed in the notification center.
            let type: ApnsType?

            #if os(Linux)
            /// Custom JSON payload that will be sent as part of the notification message.
            let payload: [String: Any]?
            #else
            /// Custom JSON payload that will be sent as part of the notification message.
            let payload: [String: AnyObject]?
            #endif

            #if os(Linux)
            public init(badge: Int?, category: String?, iosActionKey: String?, sound: String?, type: ApnsType?, payload: [String: Any]?) {

                self.badge = badge
                self.category = category
                self.iosActionKey = iosActionKey
                self.sound = sound
                self.type = type
                self.payload = payload
            }
            #else
            public init(badge: Int?, category: String?, iosActionKey: String?, sound: String?, type: ApnsType?, payload: [String: AnyObject]?) {

                self.badge = badge
                self.category = category
                self.iosActionKey = iosActionKey
                self.sound = sound
                self.type = type
                self.payload = payload
            }
            #endif


            internal var jsonFormat: JSON? {

                #if os(Linux)
                    var json: [String: Any] = [:]
                #else
                    var json: [String: AnyObject] = [:]
                #endif

                json["badge"] = badge
                json["category"] = category
                json["iosActionKey"] = iosActionKey
                json["sound"] = sound
                json["type"] = type?.rawValue
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
             Settings specific to the Android platform.
         */
        public struct Gcm {

            /// Identifies a group of messages.
            let collapseKey: String?

            /// Indicates whether the message should not be sent until the device becomes active.
            let delayWhileIdle: Bool?

            /// Custom JSON payload that will be sent as part of the notification message.
            let payload: String?

            /// The priority of the message.
            let priority: GcmPriority?

            /// The sound file (on device) that will be attempted to play when the notification arrives on the device.
            let sound: String?

            /// Specifies how long (in seconds) the message should be kept in GCM storage if the device is offline.
            let timeToLive: Double?

            public init(collapseKey: String?, delayWhileIdle: Bool?, payload: String?, priority: GcmPriority?, sound: String?, timeToLive: Double?) {

                self.collapseKey = collapseKey
                self.delayWhileIdle = delayWhileIdle
                self.payload = payload
                self.priority = priority
                self.sound = sound
                self.timeToLive = timeToLive
            }


            internal var jsonFormat: JSON? {

                #if os(Linux)
                    var json: [String: Any] = [:]
                #else
                    var json: [String: AnyObject] = [:]
                #endif

                json["collapseKey"] = collapseKey

                if let delay = delayWhileIdle {
					json["delayWhileIdle"] = delay ? "true" : "false"
                }

                json["payload"] = payload
                json["priority"] = priority?.rawValue
                json["sound"] = sound
                json["timeToLive"] = timeToLive

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
