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

public enum PushNotificationsError: Int {
    
    case ConnectionFailure = 1
    case InvalidNotification = 2
    case Unauthorized = 401
    case NotFound = 404
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