//
//  NetworkModel.swift
//  PeoplemonGo
//
//  Created by Deb Ramey on 11/6/16.
//  Copyright © 2016 Deb Ramey. All rights reserved.
//

import Foundation
import Alamofire
import Freddy
//Describes what you need to make a network request and read it
protocol NetworkModel: JSONDecodable {
    //create the object by reading JSON
    init(json: JSON) throws
    //create an empty object
    init()
    //what is the HTTP method (Get post put ect)
    func method() -> Alamofire.HTTPMethod
    //rest URL to the resource ie HTTP:??server.come/posts/1
    func path() -> String
    //convert the object to a dictionary
    func toDictionary() -> [String: AnyObject]?
    
}
