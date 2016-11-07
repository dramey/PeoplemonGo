//
//  Person.swift
//  PeoplemonGo
//
//  Created by Deb Ramey on 11/6/16.
//  Copyright © 2016 Deb Ramey. All rights reserved.
//

import UIKit
import Alamofire
import Freddy
import MapKit

class Person: NetworkModel {

    var userId: String?
    var userName: String?
    var avatar: String?
    var latitude: Double?
    var longitude: Double?
    var created: String?
    var radius: Double?
    
    
    
    enum RequestType {
        case nearby
        case checkIn
        case catchPerson
        case caught
        case conversations
        case conversation
        
    }
   var requestType: RequestType = .nearby
   
    required init() {}
    
    // create an object from JSON
    required init(json: JSON) throws {
        userId = try? json.getString(at: Constants.Person.userId)
        userName = try? json.getString(at: Constants.Person.userName)
        avatar = try? json.getString(at: Constants.Person.avatar)
        latitude = try? json.getDouble(at: Constants.Person.latitude)
        longitude = try? json.getDouble(at: Constants.Person.longitude)
        created = try? json.getString(at: Constants.Person.created)
        radius = try? json.getDouble(at: Constants.Person.radius)
    }
    
    // Always return HTTP.GET
    func method() -> Alamofire.HTTPMethod {
        switch requestType {
        case .checkIn:
            return .post
        case .catchPerson:
            return .post
        default:
            return .get
        }
    }
    // A sample path to a single post
    func path() -> String {
        switch requestType {
        case .nearby:
            return "/v1/User/Nearby"
        case .checkIn:
            return "/v1/User/CheckIn"
        case .catchPerson:
            return "/v1/User/Catch"
        case .caught:
            return "/v1/User/Caught"
            
        case .conversations:
            return "/v1/User/Conversations"
            
        case .conversation:
            return "/v1/User/Conversation"
        }
    }
    // Demo object isn't being posted to a server, so just return nil
    func toDictionary() -> [String: AnyObject]? {
        switch requestType {
        case .checkIn:
            //let startDate = Utils.adjustedTime().toString(.iso8601(nil))
            
            var params: [String: AnyObject] = [:]
            params[Constants.Person.userName] = userName as AnyObject?
            params[Constants.Person.latitude] = latitude as AnyObject?
            params[Constants.Person.longitude] = longitude as AnyObject?
            
            return params
        case .catchPerson:
            //needs work
            var params: [String: AnyObject] = [:]
            params[Constants.Person.userName] = userName as AnyObject?
            params[Constants.Person.latitude] = latitude as AnyObject?
            params[Constants.Person.longitude] = longitude as AnyObject?
            
            return params
        default:
            return nil
        }
    }


    
}
/*

// Just a test object to excercise the network stack
class Category : NetworkModel {
    /*
     "id": 0,
     "name": "string",
     "amount": 0
     */
    
    var id : Int?
    var name : String?
    var amount : Double?
    
    var startDate : String?
    var endDate : String?
    
    // Request Type
    enum RequestType {
        case create
        case week
        case month
    }
    var requestType = RequestType.week
    
    var searchDate : Date?
    
    // empty constructor
    required init() {}
    
    // create an object from JSON
    required init(json: JSON) throws {
        id = try? json.getInt(at: Constants.Category.id)
        name = try? json.getString(at: Constants.Category.name)
        amount = try? json.getDouble(at: Constants.Category.amount)
    }
    
    init(name: String, amount: Double) {
        self.name = name
        self.amount = amount
        requestType = .create
    }
    
    init(month: Date) {
        requestType = .month
        searchDate = month
    }
    
    init(week:Date) {
        requestType = .week
        searchDate = week
    }
    
    // Always return HTTP.GET
    func method() -> Alamofire.HTTPMethod {
        switch requestType {
        case .create:
            return .post
        default:
            return .get
        }
    }
    
    // A sample path to a single post
    func path() -> String {
        switch requestType {
        case .create:
            return "/api/category/createCategory"
        case .week:
            return "/api/category/getCategory/year/\(searchDate!.year())/month/\(searchDate!.month())/day/\(searchDate!.day())"
        case .month:
            return "/api/category/getCategory/year/\(searchDate!.year())/month/\(searchDate!.month())"
        }
    }
    
    // Demo object isn't being posted to a server, so just return nil
    func toDictionary() -> [String: AnyObject]? {
        switch requestType {
        case .create:
            let startDate = Utils.adjustedTime().toString(.iso8601(nil))
            
            var params: [String: AnyObject] = [:]
            params[Constants.Category.name] = name as AnyObject?
            params[Constants.Category.amount] = amount as AnyObject?
            params[Constants.Category.startDate] = startDate as AnyObject?
            
            return params
        default:
            return nil
        }
    }*/
    


