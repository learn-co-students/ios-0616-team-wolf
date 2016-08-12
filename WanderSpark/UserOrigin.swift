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

class UserOrigin
{
    static let sharedOrigin = UserOrigin()
    private init() {}
    var location: CLLocation?
    
    
//    var locationManager = CLLocationManager()
    
    
//    init(userOriginCoordinates: CLLocation) {
//        self.userOriginCoordinates = userOriginCoordinates
//    }
    
    
//    convenience override init() {
//        self.init(userOriginCoordinates: CLLocation(latitude: 40.730610, longitude: -73.935242))
//    }
//    
//    
////This function is created so as to get permission to get the user's location
//    func checkCoreLocationPermission()
//    {
//        locationManager.delegate = self
//        locationManager = CLLocationManager()
//        
//        locationManager.desiredAccuracy = kCLLocationAccuracyBest
//        locationManager.requestLocation()
//        if CLLocationManager.authorizationStatus() == .AuthorizedWhenInUse
//        {
//            locationManager.startUpdatingLocation()
//            
//        }
//        else if CLLocationManager.authorizationStatus() == .NotDetermined
//        {
//            locationManager.requestWhenInUseAuthorization()
//        }
//        else if CLLocationManager.authorizationStatus() == .Restricted
//        {
//            print("Error! Please Provide Information")
//        }
//    }
//    
//    
//    
//    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
//    {
//        print("\nlocation manager\n")
//        //checkCoreLocationPermission()
//        guard let lastLocation = locations.first else { fatalError("no locations") }
//        self.userOriginCoordinates = lastLocation
//        
//    }
    


}
    


