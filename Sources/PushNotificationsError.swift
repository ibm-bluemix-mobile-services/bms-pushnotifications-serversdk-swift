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
import SimpleHttpClient


/**
    Used to indicate failures that may occur during BluemixPushNotifications operations.
*/
public enum PushNotificationsError: Int, ErrorProtocol {
    
    /// A failure occurred when attempting to connect to the Push service.
    case ConnectionFailure = 1
    
    /// The provided Notification object contains invalid data.
    case InvalidNotification = 2
    
    /// Could not obtain authorization from the Push service.
    /// Check that the bluemixAppGuid and bluemixAppSecret in the PushNotifications initializer are correct.
    case Unauthorized = 401
    
    /// The Push service is not available on the server.
    case NotFound = 404
    
    /// The Push service was not able to process the request. 
    /// If posting a notification, check that the sent Notification object contains the correct data.
    case ServerError = 500
    
    
    internal static func from(httpError: HttpError?) -> PushNotificationsError? {
        
        switch httpError {
            
        case nil:
            return nil
        case HttpError.Unauthorized?:
            return PushNotificationsError.Unauthorized
        case HttpError.NotFound?:
            return PushNotificationsError.NotFound
        case HttpError.ServerError?:
            return PushNotificationsError.ServerError
        default:
            return PushNotificationsError.ConnectionFailure
        }
    }
}