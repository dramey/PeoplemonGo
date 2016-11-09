//
//  MapViewController.swift
//  PeoplemonGo
//
//  Created by Deb Ramey on 11/8/16.
//  Copyright © 2016 Deb Ramey. All rights reserved.
//

import UIKit
import MapKit
import MBProgressHUD
import CoreLocation

class MapViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    
    
    let locationManager = CLLocationManager()
    var updateLocation = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("view loaded")
        // Do any additional setup after loading the view.
        self.locationManager.delegate = self
        
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse{
            self.mapView.showsUserLocation = true
            self.locationManager.startUpdatingLocation()
            
            Timer.scheduledTimer(withTimeInterval: 5, repeats: true, block: {(timer:Timer) in
                
                if let coordinate = self.locationManager.location?.coordinate{
                    let annonation = MKPointAnnotation ()
                    annonation.coordinate = coordinate
                    
                    annonation.coordinate.latitude += (Double(arc4random_uniform(1000)) - 500)/300000.0
                    annonation.coordinate.longitude += (Double(arc4random_uniform(1000)) - 500)/300000.0
                    self.mapView.addAnnotation(annonation)
                }
            })
            
        }else{
            self .locationManager.requestWhenInUseAuthorization()
        }
    }
    func locationManager(_ manager:CLLocationManager, didUpdateLocations locations: [CLLocation]){
        
        if updateLocation < 4 {
            let myArea = MKCoordinateRegionMakeWithDistance(self.locationManager.location!.coordinate, 1000, 1000)
            self.mapView.setRegion(myArea, animated: true)
        }
        updateLocation += 1
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //print("view appeared")
        if !WebServices.shared.userAuthTokenExists() || WebServices.shared.userAuthTokenExpired(){
            performSegue(withIdentifier: "PresentLoginNoAnimation", sender: self)
            //print("I got here")
        }
    }
    //Mark - @IBActions
    @IBAction func logout(_ sender: Any) {
        UserStore.shared.logout{
            self.performSegue(withIdentifier: "PresentLogin", sender: self)
        }

    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
