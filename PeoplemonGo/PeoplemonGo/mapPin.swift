//
//  mapPin.swift
//  PeoplemonGo
//
//  Created by Deb Ramey on 11/9/16.
//  Copyright © 2016 Deb Ramey. All rights reserved.
//
import UIKit
import MapKit


class MapPin: NSObject, MKAnnotation {
    var coordinate:CLLocationCoordinate2D
    var person: Person?
    //var title: String?
    
    init(person: Person){
        self.person = person
        //self.title = title
        if let lat = person.latitude, let long = person.longitude{
            self.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
            
        }else {
            self.coordinate = CLLocationCoordinate2D(latitude: 0, longitude: 0)
        }
    }
}
