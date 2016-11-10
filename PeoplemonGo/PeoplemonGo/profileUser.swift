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
    
    var image: UIImage?
    
    let imageKey = "image"
    
    override init(){
        super.init()
        
    }
    //creating a custom initializer --convenience initializer
    //init(oldPassword: String, newPassword: String){
       
    //}
    required init?(coder aDecoder: NSCoder) {
    
        self.image = aDecoder.decodeObject(forKey: imageKey) as? UIImage
    }
    func encode(with aCoder: NSCoder) {
       
        aCoder.encode(image, forKey: imageKey)
    }
    
}
