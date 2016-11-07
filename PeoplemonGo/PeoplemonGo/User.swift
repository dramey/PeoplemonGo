//
//  User.swift
//  PeoplemonGo
//
//  Created by Deb Ramey on 11/6/16.
//  Copyright © 2016 Deb Ramey. All rights reserved.
//

import Foundation
import Alamofire
import Freddy

// Just a test object to excercise the network stack
class User : NetworkModel {
    /*
     "username": "string",
     "password": "string",
     "email": "string"
     "token": "string",
     "expiration": "2016-11-01T20:58:52.318Z"
     */
    
    var id : Int?
    var username : String?
    var password : String?
    var email : String?
    var apiKey : String?
    var expiration : String?
    
    // Request Type
    enum RequestType {
        case login
        case register
    }
    var requestType = RequestType.login
    
    
    // empty constructor
    required init() {}
    
    // create an object from JSON
    required init(json: JSON) throws {
        apiKey = try? json.getString(at: Constants.User.apiKey)
        expiration = try? json.getString(at: Constants.User.expirationDate)
    }
    
    init(username: String, password: String) {
        self.username = username
        self.password = password
        requestType = .login
    }
    
    init(username: String, password: String, email: String) {
        self.username = username
        self.password = password
        self.email = email
        requestType = .register
    }
    
    init(id: Int) {
        self.id = id
    }
    
    // Always return HTTP.GET
    func method() -> Alamofire.HTTPMethod {
        return .post
    }
    
    // A sample path to a single post
    func path() -> String {
        switch requestType {
        case .login:
            return "/auth"
        case .register:
            return "/register"
        }
    }
    
    // Demo object isn't being posted to a server, so just return nil
    func toDictionary() -> [String: AnyObject]? {
        
        var params: [String: AnyObject] = [:]
        params[Constants.User.username] = username as AnyObject?
        params[Constants.User.password] = password as AnyObject?
        
        
        switch requestType {
        case .register:
            params[Constants.User.email] = email as AnyObject?
        default:
            break
        }
        
        return params
    }
    
}
