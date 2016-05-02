//
//  Notification.swift
//  BluemixPushNotifications
//
//  Created by Anthony Oliveri on 5/2/16.
//  Copyright © 2016 IBM. All rights reserved.
//

import Foundation


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
