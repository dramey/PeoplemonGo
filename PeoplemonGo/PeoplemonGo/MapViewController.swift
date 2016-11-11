//
//  MapViewController.swift
//  PeoplemonGo
//
//  Created by Deb Ramey on 11/8/16.
//  Copyright © 2016 Deb Ramey. All rights reserved.
//
import Foundation
import MapKit
import Alamofire
import MBProgressHUD
import CoreLocation

class MapViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    
    
    let locationManager = CLLocationManager()
    var updateLocation = true
    var latitudeDelta = 0.002
    var longitudeDelta = 0.002
    var annotations: [MapPin] = []
    var overlay: MKOverlay?
    
    var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mapView.delegate = self

        // Do any additional setup after loading the view.
        self.locationManager.delegate = self
        self.locationManager.distanceFilter = kCLDistanceFilterNone
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse{
            self.mapView.showsUserLocation = true
            self.locationManager.startUpdatingLocation()
            
            
        }else{
            self.locationManager.requestWhenInUseAuthorization()
        }
        mapView.mapType = MKMapType.hybrid     //
        loadMap()
    }
    func locationManager(_ manager:CLLocationManager, didUpdateLocations locations: [CLLocation]){
       
        let myArea = MKCoordinateRegionMakeWithDistance(self.locationManager.location!.coordinate, 500, 500)
        self.mapView.setRegion(myArea, animated: true)
        updateLocation = false   //
        locationManager.stopUpdatingLocation()    //
       
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if !WebServices.shared.userAuthTokenExists() || WebServices.shared.userAuthTokenExpired(){
            performSegue(withIdentifier: "PresentLoginNoAnimation", sender: self)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        stopTimer()
    }
    
    func loadMap(){
        if let coordinate = locationManager.location?.coordinate {
            let checkIn = Person(longitude: coordinate.longitude, latitude: coordinate.latitude)
            WebServices.shared.postObject(checkIn, completion: { (object, error) in
            })
            
        
        }
        let peopleNearby = Person(radius: 100)
        WebServices.shared.getObjects(peopleNearby){
            (nearbyPeople, error) in
            if let nearbyPeople = nearbyPeople{
                let otherAnnotations = self.annotations
                self.annotations = []
                for person in nearbyPeople {
                    let pin = MapPin(person: person)
                    self.annotations.append(pin)
                }
                self.mapView.addAnnotations(self.annotations)
                self.mapView.removeAnnotations(otherAnnotations)
            }
        }
    }
    func beginTimer(){
        timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(loadMap), userInfo: nil, repeats: true)
    }
    func stopTimer(){
        timer?.invalidate()
        timer = nil
    }
  
    
    //Mark - @IBActions
    @IBAction func logout(_ sender: Any) {
        UserStore.shared.logout{
            self.performSegue(withIdentifier: "PresentLogin", sender: self)
        }
        
    }

    @IBAction func CheckIn(_ sender: AnyObject) {
        //get the location
        if let location = locationManager.location{
            
            let coordinate = location.coordinate
      
        }
       loadMap()
   
        
    }
}
extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView?{
        if annotation is MKUserLocation {
            return nil
        }
        let reuseId = "pin"
        
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.canShowCallout = true
            pinView!.animatesDrop = true
            
        } else{
            pinView!.annotation = annotation
        }
        return pinView
    }
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if let mapPin = view.annotation as? MapPin, let people = mapPin.person, let name = people.userName, let userId = people.userId {
            let alert = UIAlertController(title: "Catch User", message: "Catch\(name)?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Catch", style: .default, handler: { (action) in
                let catchPeople = Person(caughtUserId: userId, radius: Constants.radius)
                WebServices.shared.postObject(catchPeople, completion: { (object, error) in
                    if let error = error{
                        self.present(Utils.createAlert(message: error), animated: true, completion: nil)
                    } else{
                        self.present(Utils.createAlert("AWESOME!", message: "User Caught"), animated: true, completion: nil)
                    }
                })
            }))
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        self.overlay = overlay
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = UIColor.green
        renderer.lineWidth = 5.0
        renderer.lineCap = CGLineCap.round
        return renderer
    }
}

    


