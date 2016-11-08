//
//  UserStore.swift
//  PeoplemonGo
//
//  Created by Deb Ramey on 11/6/16.
//  Copyright © 2016 Deb Ramey. All rights reserved.
//

import Foundation


class UserStore {
    // singleton
    static let shared = UserStore()
    private init() {}
    
    func login(_ loginUser: User, completion:@escaping
        (_ success:Bool, _ error: String?) -> ()) {
        
        // Call web service to login
        WebServices.shared.authUser(loginUser) { (user, error) in
            if let user = user {
                WebServices.shared.setAuthToken(user.token, expiration: user.expiration)
                completion(true, nil)
            } else {
                completion(false, error)
            }
        }
    }
    
    func register(_ registerUser: User, completion:@escaping
        (_ success:Bool, _ error: String?) -> ()) {
        
        // Call web service to login
        WebServices.shared.authUser(registerUser) { (user, error) in
            if let user = user {
                WebServices.shared.setAuthToken(user.token, expiration: user.expiration)
                completion(true, nil)
            } else {
                completion(false, error)
            }
        }
    }
    
    func logout(_ completion:() -> ()) {
        WebServices.shared.clearUserAuthToken()
        completion()
    }
    
}
