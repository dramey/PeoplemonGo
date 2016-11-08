//
//  Account.swift
//  PeoplemonGo
//
//  Created by Deb Ramey on 11/6/16.
//  Copyright © 2016 Deb Ramey. All rights reserved.
//

import Foundation
import Alamofire
import Freddy

class User : NetworkModel {
 
    var id: String?
    var userName: String?
    var email : String?
    var hasRegistered: Bool?
    var loginProvider: String?
    var fullName: String?
    var avatarBase64: String?
    var lastCheckInLongitude: Double?
    var lastCheckInLatitude: Double?
    var lastCheckInDateTime: String?
    var oldPassword: String?
    var newPassword: String?
    var confirmPassword: String?
    var apiKey: String?
    var password: String?
    var token: String?
    var expiration : String?
    var grantType: String?
    
    
    // Request Type
    enum RequestType {
        case login
        case userInfo
        case changePassword
        case setPassword
        case register
        case getUserInfo
       
    }
    var requestType = RequestType.register
    
    
    // empty constructor
    required init() {}
    
    // create an object from JSON
    required init(json: JSON) throws {
        id = try? json.getString(at: Constants.User.id)
        userName = try? json.getString(at: Constants.User.userName)
        email = try? json.getString(at: Constants.User.email)
        hasRegistered = try? json.getBool(at: Constants.User.hasRegistered)
        loginProvider = try? json.getString(at: Constants.User.loginProvider)
        fullName = try? json.getString(at: Constants.User.fullName)
        avatarBase64 = try? json.getString(at: Constants.User.avatarBase64)
        lastCheckInLongitude = try? json.getDouble(at: Constants.User.lastCheckInLongitude)
        lastCheckInLatitude = try? json.getDouble(at: Constants.User.lastCheckInLatitude)
        lastCheckInDateTime = try? json.getString(at: Constants.User.lastCheckInDateTime)
        oldPassword = try? json.getString(at: Constants.User.oldPassword)
        newPassword = try? json.getString(at: Constants.User.newPassword)
        confirmPassword = try? json.getString(at: Constants.User.confirmPassword)
        apiKey = try? json.getString(at: Constants.User.apiKey)
        password = try? json.getString(at: Constants.User.password)
        token = try? json.getString(at: Constants.User.token)
        expiration = try? json.getString(at: Constants.User.expirationDate)
        grantType = try? json.getString(at: Constants.User.grantType)
        
    }
    //parameters email and password
    init(email: String, password: String) {
        self.email = email
        self.password = password
        requestType = .login
    }
    init(fullName: String, avatarBase64: String) {
        self.fullName = fullName
        self.avatarBase64 = avatarBase64
        requestType = .userInfo
    }
    init(oldPassword: String, newPassword: String, confirmPassword: String) {
        self.oldPassword = oldPassword
        self.newPassword = newPassword
        self.confirmPassword = confirmPassword
        requestType = .changePassword
    }
    init(newPassword: String) {
        self.newPassword = newPassword
        requestType = .setPassword
    }

    init(fullName: String, password: String, email: String, avatarBase64: String, apiKey: String) {
        self.fullName = fullName
        self.password = password
        self.email = email
        self.avatarBase64 = avatarBase64
        self.apiKey = apiKey
        requestType = .register
    }
    init(userName: String, email: String, hasRegistered: Bool, loginProvider: String, fullName: String, avatarBase64: String, lastCheckInLongitude: Double, lastCheckInLatitude: Double, lastCheckInDateTime: String) {
        self.userName = userName
        self.email = email
        self.hasRegistered = hasRegistered
        self.loginProvider = loginProvider
        self.fullName = fullName
        self.avatarBase64 = avatarBase64
        self.lastCheckInLongitude = lastCheckInLongitude
        self.lastCheckInLatitude = lastCheckInLatitude
        self.lastCheckInDateTime = lastCheckInDateTime
        requestType = .getUserInfo
    }

    
    
    //init(id: String) {
       // self.userName = id
    //}
    
    // Always return HTTP.GET
    func method() -> Alamofire.HTTPMethod {
        switch requestType{
        case .getUserInfo:
          return .get
        default:
            return .post
        }
    }
    
    // A sample path to a single post
    func path() -> String {
        switch requestType {
        case .userInfo:
            return "/api/Account/UserInfo"
        case .changePassword:
            return "/api/Account/ChangePassword"
        case .setPassword:
            return "/api/Account/SetPassword"
        case .login:
            return "/token"
        case .register:
            return "/api/Account/Register"
        case .getUserInfo:
            return "/api/Account/UserInfo"
        
        }
    }
    
    // Demo object isn't being posted to a server, so just return nil   //switch//register parameters
    func toDictionary() -> [String: AnyObject]? {
        var params: [String: AnyObject] = [:]
        switch requestType {
        case .register:
            params[Constants.User.fullName] = fullName as AnyObject?
            params[Constants.User.email] = email as AnyObject?
            params[Constants.User.password] = password as AnyObject?
            params[Constants.User.avatarBase64] = avatarBase64 as AnyObject?
            params[Constants.User.apiKey] = apiKey as AnyObject?
            
        case .login:///login parameters with granttype username and password make username = email
            params[Constants.User.email] = email as AnyObject?
            params[Constants.User.password] = password as AnyObject?
            params[Constants.User.grantType] = grantType as AnyObject?
            
        default:
            break
        }
        
        return params
    }
    
}
