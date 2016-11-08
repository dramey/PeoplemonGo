//
//  Constants.swift
//  PeoplemonGo
//
//  Created by Deb Ramey on 11/6/16.
//  Copyright © 2016 Deb Ramey. All rights reserved.
//

import Foundation
import UIKit

struct Constants {
    static let monthDayYear = "MM/dd/yyyy"
    
    
    // Keychain strings
    public static let keychainIdentifier = "PeoplemonKeychain"
    public static let authTokenExpireDate = "authTokenExpireDate"
    public static let authToken = "authToken"
    static let apiKey = "iOSandriod301november2016"
    static let radius = 100.0
    

    
    // JSON Constants
    struct JSON {
        static let unknownError = "An Unknown Error Has Occurred"
        static let processingError = "There was an error processing the response"
    }
    
    // User Constants
    struct User {
        static let id = "id"
        static let email = "email"
        static let fullName = "fullName"
        static let userName = "username"
        static let password = "password"
        static let token = "token"
        static let apiKey = "ApiKey"
        static let expirationDate = "expiration"
        static let avatarBase64 = "AvatarBase64"
        static let grantType = "grant_type"
        static let hasRegistered = "true"
        static let loginProvider = "LoginProvider"
        static let lastCheckInLongitude = "0"
        static let lastCheckInLatitude = "0"
        static let lastCheckInDateTime = "date"
        static let oldPassword = "oldPassword"
        static let newPassword = "newPassword"
        static let confirmPassword = "confirmPassword"

    }
    
    // Person Constants
    struct Person {
        static let userId = "userId"
        static let userName = "userName"
        static let avatarBase64 = "avatarBase64"
        static let latitude = "latitude"
        static let longitude = "longitude"
        static let created = "date"
        static let radius = "radius"
        static let caughtUserId = "caughtUserId"
        static let conversationId = "conversationId"
        static let recipientId = "recipientId"
        static let recipientName = "recipientName"
        static let lastMessage = "lastMessage"
        static let messageCount = "messageCount"
        static let senderId = "senderId"
        static let senderName = "senderName"
        static let recipientAvatarBase64 = "recipientAvatarBase64"
        static let senderAvatarBase64 = "senderAvatarBase64"
        static let grantType = "grant_type"
        static let expiration = "expiration"
    
    }
   

}

// MARK: - Colors
// UIColor extension and
extension UIColor {
    public class func rgba(red: NSInteger, green: NSInteger, blue: NSInteger, alpha: Float = 1.0) -> UIColor {
        return UIColor(red: CGFloat(red)/255.0, green: CGFloat(green)/255.0, blue: CGFloat(blue)/255.0, alpha: CGFloat(alpha))
    }
}

struct ColorPalette {
    static let PositiveColor = UIColor.rgba(red: 15, green: 181, blue: 46)
    static let NegativeColor = UIColor.rgba(red: 219, green: 31, blue: 31)
    static let BlueColor = UIColor.rgba(red: 12, green: 35, blue: 64)
    static let GoldColor = UIColor.rgba(red: 201, green: 151, blue: 0)
    static let calendarCellColor = UIColor.rgba(red: 0, green: 0, blue: 0, alpha: 0.1)
    static let calendarTodayColor = UIColor.rgba(red: 12, green: 35, blue: 64, alpha: 0.3)
    static let calendarBorderColor = UIColor.rgba(red: 12, green: 35, blue: 64, alpha: 0.8)
}
