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


public struct Notification {
    
    public let message: Message
    public let target: Target?
    public let settings: Settings?
    
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
    

    public struct Message {
        
        let alert: String?
        let url: String?
        
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
    

    public struct Target {
        
        let deviceIds: [String]?
        let platforms: [TargetPlatform]?
        let tagNames: [String]?
        let userIds: [String]?
        
        internal var jsonFormat: JSON? {
            
            #if os(Linux)
                var json: [String: Any] = [:]
            #else
                var json: [String: AnyObject] = [:]
            #endif
            
            json["deviceIds"] = deviceIds
            
            #if os(Linux)
                let platformsAsStrings = NSMutableArray()
                if let platforms = platforms{
                    for platform in platforms {
                        platformsAsStrings.addObject(NSString(string: platform.rawValue))
                    }
                }
                json["platforms"] = platformsAsStrings.count == 0 ? platformsAsStrings : nil

            #else
                if let platformsAsStrings = platforms?.map({ $0.rawValue }) {
                    json["platforms"] = !platformsAsStrings.isEmpty ? platformsAsStrings : nil
                }
            #endif
            
            json["tagNames"] = tagNames
            json["userIds"] = userIds
            
            if !json.isEmpty {
                return JSON(json)
            }
            else {
                return nil
            }
        }
    }
    
    
    // MARK: -
    
    
    public struct Settings {
        
        let apns: Apns?
        let gcm: Gcm?
        
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
        
        
        public struct Apns {
            
            let badge: Int?
            let category: String?
            let iosActionKey: String?
            let sound: String?
            let type: ApnsType?
            #if os(Linux)
            let payload: [String: Any]?
            #else
            let payload: [String: AnyObject]?
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
        
        
        public struct Gcm {
            
            let collapseKey: String?
            let delayWhileIdle: Bool?
            let payload: String?
            let priority: GcmPriority?
            let sound: String?
            let timeToLive: Double?
            
            internal var jsonFormat: JSON? {
                
                #if os(Linux)
                    var json: [String: Any] = [:]
                #else
                    var json: [String: AnyObject] = [:]
                #endif
                
                json["collapseKey"] = collapseKey
                
                if let delay = delayWhileIdle {
                    #if os(Linux)
                        json["delayWhileIdle"] = delay ? ("true" as NSString) : ("false" as NSString)
                    #else
                        json["delayWhileIdle"] = delay ? "true" : "false"
                    #endif
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


public enum TargetPlatform: String {
    
    case Apple = "A"
    case Google = "G"
    case Microsoft = "M"
}


public enum ApnsType: String {
    
    case DEFAULT
    case MIXED
    case SILENT
}


public enum GcmPriority: String {
    
    case DEFAULT
    case MIN
    case LOW
    case HIGH
    case MAX
}
