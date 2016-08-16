//
//  UserOrigin.swift
//  WanderSpark
//
//  Created by Flatiron School on 8/11/16.
//  Copyright © 2016 Zain Nadeem. All rights reserved.
//

import Foundation
import CoreLocation

//Remember the location has the properties called coordinates and that has properties called latitude and longitude to get the user's user information

class UserOrigin: NSObject, CLLocationManagerDelegate
{
    static let sharedOrigin = UserOrigin()
    var locationManager: CLLocationManager = CLLocationManager()
    var userCoordinates: CLLocationCoordinate2D
    
    
    init(userCoordinates: CLLocationCoordinate2D) {
        self.userCoordinates = userCoordinates
    }  
    
    override init() {
        self.userCoordinates = CLLocationCoordinate2D(latitude: 40.730610, longitude: -73.935242)
    }
    
    
//This function is created so as to get permission to get the user's location
   func checkCoreLocationPermission()
    {
        //print("Entered Here!!!!!!!!!!!!!!!!!!!!!!!!1")
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestLocation()
        
        //print("Entered Here!!!!!!!!!!!!!!!!!!!!!!!!2")
        if CLLocationManager.authorizationStatus() == .AuthorizedWhenInUse || CLLocationManager.authorizationStatus() == .AuthorizedAlways {
            locationManager.startUpdatingLocation()
            //print("This worked and went through") //not entering here
//            return true
        }
        else{
            // Investigate the default alert that this shows to the user. We want to add something saying, "New York is the default origin for flights, if you do not enable Location Services."
            //print("Entered Here!!!!!!!!!!!!!!!!!!!!!!!!3")
            locationManager.requestWhenInUseAuthorization()
            //print("This is the second step")
//            return false
        }
    }
    
    
    ///Not entering here!!!!!
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
//        if self.checkCoreLocationPermission() {
        //print("Entered Here!!!!!!!!!!!!!!!!!!!!!!!!4")
        guard let lastLocation = locations.first else { fatalError("no locations") }
        self.userCoordinates = lastLocation.coordinate
        
        print(userCoordinates)
        
        locationManager.stopUpdatingHeading() 
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        //print("Entered Here!!!!!!!!!!!!!!!!!!!!!!!!5")
        //print("Failed to find user's location: \(error.localizedDescription)")
    }
    
}
    


