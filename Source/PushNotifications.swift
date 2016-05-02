//
//  PushNotifications.swift
//  BluemixPushNotifications
//
//  Created by Anthony Oliveri on 5/2/16.
//  Copyright © 2016 IBM. All rights reserved.
//


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

