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


public struct PushNotifications {
    
    public let appId: String
    public let appSecret: String
    public let region: String
    
    public func send(notification: Notification) {
        
    }
    
    
    public struct Region {
        
        public static let US_SOUTH = ".ng.bluemix.net"
        public static let UK = ".eu-gb.bluemix.net"
        public static let SYDNEY = ".au-syd.bluemix.net"
    }
}

