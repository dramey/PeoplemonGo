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
   
    var image: UIImage?
    
    
    let fullNameKey = "fullName"

    let imageKey = "image"
    
    override init(){
        super.init()
        
    }
    //creating a custom initializer --convenience initializer
    init(fullName: String){
        self.fullName = fullName
       
       
    }
    required init?(coder aDecoder: NSCoder) {
        self.fullName = aDecoder.decodeObject(forKey: fullNameKey) as! String
        self.image = aDecoder.decodeObject(forKey: imageKey) as? UIImage
    }
    func encode(with aCoder: NSCoder) {
        aCoder.encode(fullName, forKey: fullNameKey)
        aCoder.encode(image, forKey: imageKey)
    }
           }
   
