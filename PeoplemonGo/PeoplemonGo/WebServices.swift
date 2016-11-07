//
//  WebServices.swift
//  PeoplemonGo
//
//  Created by Deb Ramey on 11/6/16.
//  Copyright © 2016 Deb Ramey. All rights reserved.
//

import Foundation
import Alamofire
import Freddy
import Valet


//central router to create URLRequestConvertibel requests
class WebServices: NSObject{
    
    
    //Singleton
    
    static let shared = WebServices()
    
    //prevent object creation- private - only objects in this class
    private override init (){}
    
    
    //baseURL private and public vars
    
    fileprivate var _baseURL = ""
    var baseURL : String {
        get{
            return _baseURL
            
        }
        set {
            _baseURL = newValue
        }
    }
    
    //Store auth token--fileprivate--locks done tight
    
    fileprivate var authToken: String?{
        get{
            let myValet = VALValet(identifier: Constants.keychainIdentifier, accessibility: .whenUnlocked)
            //not storing in private variable--get template out of key chain
            if let authTokenString = myValet?.string(forKey: Constants.authToken){
                return authTokenString
            }else{
                return nil
            }
        }
        //Adding setter
        set{
            let myValet = VALValet(identifier: Constants.keychainIdentifier, accessibility: .whenUnlocked)
            
            if let newValue = newValue{
                myValet?.setString(newValue, forKey: Constants.authToken)
            }else{
                myValet?.removeObject(forKey: Constants.authToken)
            }
        }
        
    }
    fileprivate var authTokenExpireDate: String?{
        get{
            let myValet = VALValet(identifier: Constants.keychainIdentifier, accessibility: .whenUnlocked)
            
            if let authExpireDate = myValet?.string(forKey: Constants.authTokenExpireDate){
                return authExpireDate
            }else{
                return nil
            }
        }
        //Adding setter
        set{
            let myValet = VALValet(identifier: Constants.keychainIdentifier, accessibility: .whenUnlocked)
            
            if let newValue = newValue{
                myValet?.setString(newValue, forKey: Constants.authTokenExpireDate)
            }else{
                myValet?.removeObject(forKey: Constants.authTokenExpireDate)
            }
        }
        
    }
    
    
    
    func setAuthToken(_ token: String?, expiration: String?){
        authToken = token
        authTokenExpireDate = expiration
    }
    
    // Function to check for authToken
    func userAuthTokenExists() -> Bool {
        if self.authToken != nil {
            return true
        }
        else {
            return false
        }
    }
    
    // Function to check if authToken is expired
    func userAuthTokenExpired() -> Bool {
        if self.authTokenExpireDate != nil {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "EEE, dd MMM yyyy HH:mm:ss Z"
            
            let dateString = self.authTokenExpireDate!
            if let expireDate = dateFormatter.date(from: dateString) {
                let hourFromNow = Date().addingTimeInterval(3600)
                
                if expireDate.compare(hourFromNow) == ComparisonResult.orderedAscending {
                    return true
                } else {
                    return false
                }
            } else {
                return true
            }
        } else {
            return true
        }
    }
    
    // Function to clear the auth token
    func clearUserAuthToken() {
        if self.userAuthTokenExists() {
            self.authToken = nil
        }
    }
    
    
    
    //AuthRouter - all network calls go through this look at request type (restRequest) and creates a URL request
    enum AuthRouter: URLRequestConvertible {
        static var baseURLString = WebServices.shared._baseURL
        static var OAuthToken: String?
        
        // Because AuthRouter is an enum, it needs to have a case to instantiate it
        case restRequest(NetworkModel)
        
        func asURLRequest() throws -> URLRequest {
            let URL = try AuthRouter.baseURLString.asURL()
            var urlRequest: URLRequest
            
            switch self {
            case .restRequest(let model):
                // Create the url request with the base url and add on the path component passed in via the NetworkModel
                urlRequest = URLRequest(url: URL.appendingPathComponent(model.path()))
                
                // Set the method to the method passed in via the NetworkModel
                urlRequest.httpMethod = model.method().rawValue
                
                // Check for an auth token and if it exists, add it to the request
                if let token = WebServices.shared.authToken {
                    urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
                }
                
                // Check for parameters and eithe radd them to the URL or the body depending on the Method
                if let params = model.toDictionary() {
                    if model.method() == .get {
                        return try! URLEncoding.default.encode(urlRequest, with: params)
                    } else {
                        return try! JSONEncoding.default.encode(urlRequest, with: params)
                    }
                }
                
                return urlRequest
            }
        }
    }
    
    
}
