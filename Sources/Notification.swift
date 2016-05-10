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


public struct Notification {
    
    public let message: Message
    public let target: Target?
    public let settings: Settings?
    
    internal var jsonFormat: [String: AnyObject]? {
        
        var json = [:] as [String: AnyObject]
        
        json["message"] = message.jsonFormat as? AnyObject
        json["target"] = target?.jsonFormat as? AnyObject
        json["settings"] = settings?.jsonFormat as? AnyObject
        
        if !json.isEmpty {
            return json
        }
        else {
            return nil
        }
    }
    
    
    // MARK: -
    

    public struct Message {
        
        let alert: String?
        let url: String?
        
        internal var jsonFormat: [String: AnyObject]? {
            
            var json = [:] as [String: AnyObject]
            
            json["alert"] = alert as? AnyObject
            json["url"] = url as? AnyObject
            
            if !json.isEmpty {
                return json
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
        
        internal var jsonFormat: [String: AnyObject]? {
            
            var json = [:] as [String: AnyObject]
            
            json["deviceIds"] = deviceIds as? AnyObject
            
            #if os(OSX)
                if let platformsAsStrings = platforms?.map({ $0.rawValue }) {
                    json["platforms"] = !platformsAsStrings.isEmpty ? platformsAsStrings : nil
                }
            #elseif os(Linux)
                let platformsAsStrings = NSMutableArray()
                if let platforms = platforms{
                    for platform in platforms {
                        platformsAsStrings.addObject(NSString(string: platform.rawValue))
                    }
                }
                json["platforms"] = platformsAsStrings.count == 0 ? platformsAsStrings : nil
            #endif
            
            json["tagNames"] = tagNames as? AnyObject
            json["userIds"] = userIds as? AnyObject
            
            if !json.isEmpty {
                return json
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
        
        internal var jsonFormat: [String: AnyObject]? {
            
            var json = [:] as [String: AnyObject]
            
            json["apns"] = apns?.jsonFormat as? AnyObject
            json["gcm"] = gcm?.jsonFormat as? AnyObject
            
            if !json.isEmpty {
                return json
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
            let payload: [String: AnyObject]?
            let sound: String?
            let type: ApnsType?
            
            internal var jsonFormat: [String: AnyObject]? {
                
                var json = [:] as [String: AnyObject]
                
                json["badge"] = badge as? AnyObject
                json["category"] = category as? AnyObject
                json["iosActionKey"] = iosActionKey as? AnyObject
                json["payload"] = payload as? AnyObject
                json["sound"] = sound as? AnyObject
                json["type"] = type?.rawValue as? AnyObject
                
                if !json.isEmpty {
                    return json
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
            
            internal var jsonFormat: [String: AnyObject]? {
                
                var json = [:] as [String: AnyObject]
                
                json["collapseKey"] = collapseKey as? AnyObject
                
                if let delay = delayWhileIdle {
                    #if os(OSX)
                        json["delayWhileIdle"] = delay ? "true" : "false"
                    #elseif os(Linux)
                        json["delayWhileIdle"] = delay ? ("true" as NSString) : ("false" as NSString)
                    #endif
                }
                
                json["payload"] = payload as? AnyObject
                json["priority"] = priority?.rawValue as? AnyObject
                json["sound"] = sound as? AnyObject
                json["timeToLive"] = timeToLive as? AnyObject
                
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
