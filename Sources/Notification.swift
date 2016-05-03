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


public struct Notification {
    
    public let message: Message
    public let target: Target?
    public let settings: Settings?
    

    public struct Message {
        
        let alert: String?
        let url: String?
    }


    public struct Target {
        
        let deviceIds: [String]?
        let platforms: [String]?
        let tagNames: [String]?
        let userIds: [String]?
    }
    
    
    public struct Settings {
        
        let apns: Apns?
        let gcm: Gcm?
        
        
        public struct Apns {
            
            let badge: Int?
            let category: String?
            let iosActionKey: String?
            let payload: [String: AnyObject]?
            let sound: String?
            let type: String?
        }
        
        
        public struct Gcm {
            
            let collapseKey: String?
            let delayWhileIdle: String?
            let payload: String?
            let priority: String?
            let sound: String?
            let timeToLive: String?
        }
    }
}
