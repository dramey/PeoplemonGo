//
//  profileUser.swift
//  PeoplemonGo
//
//  Created by Deb Ramey on 11/9/16.
//  Copyright © 2016 Deb Ramey. All rights reserved.
//

import Foundation
import UIKit


class ProfileUser: NSObject, NSCoding{
    
    var fullName = ""
    var oldPassword = ""
    var newPassword = ""
    var image: UIImage?
    
    
    let fullNameKey = "fullName"
    let oldPasswordKey = "oldPassword"
    let newPasswordKey = "newPassword"
    let imageKey = "image"
    
    override init(){
        super.init()
        
    }
    //creating a custom initializer --convenience initializer
    init(fullName: String, oldPassword: String, newPassword: String){
        self.fullName = fullName
        self.oldPassword = oldPassword
        self.newPassword = newPassword
       
    }
    required init?(coder aDecoder: NSCoder) {
        self.fullName = aDecoder.decodeObject(forKey: fullNameKey) as! String
        self.oldPassword = aDecoder.decodeObject(forKey: oldPasswordKey) as! String
        self.newPassword = aDecoder.decodeObject(forKey: newPasswordKey) as! String
        self.image = aDecoder.decodeObject(forKey: imageKey) as? UIImage
    }
    func encode(with aCoder: NSCoder) {
        aCoder.encode(fullName, forKey: fullNameKey)
        aCoder.encode(oldPassword, forKey: oldPasswordKey)
        aCoder.encode(newPassword, forKey: newPasswordKey)
        aCoder.encode(image, forKey: imageKey)
    }
    
}
