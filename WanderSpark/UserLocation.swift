//
//  ObtainUserOrigin.swift
//  
//
//  Created by Flatiron School on 8/22/16.
//
//

import Foundation
import CoreLocation


class UserLocation: NSObject, CLLocationManagerDelegate {
//    override init() {}
    
    var locationManager: CLLocationManager?
    var location: CLLocation?
    var userCoordinates: CLLocationCoordinate2D?
    var userPostalCode: String?
    var userZipCodeCoordinates : (Double, Double)?
    
    static let sharedInstance = UserLocation()
    
    private override init() {
        locationManager = CLLocationManager()
        super.init()
        guard let locationManager = locationManager else { return }
        if CLLocationManager.authorizationStatus() == .NotDetermined {
            locationManager.requestWhenInUseAuthorization()
        }
        
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.delegate = self
        startUpdatingLocation()
    }
    
    func startUpdatingLocation() {
        print("Starting Location Updates")
        self.locationManager?.startUpdatingLocation()
    }
    
    func stopUpdatingLocation() {
        print("Stop Location Updates")
        self.locationManager?.stopUpdatingLocation()
    }
    
    //function to get coordinates for the user's origin as well as the zipcode of the user
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        print("*************************ENTERED INTO DIDUPDATELOCATION")
        if let lastLocation = locations.last {
            self.location = lastLocation
            self.userCoordinates = lastLocation.coordinate
            print("userCoordinates: \(userCoordinates)")
            stopUpdatingLocation()
        }else {
            print("Could not get most recent user location coordinates from CLLocation array.")
        }
    }
    
    
    //this is to account for the error that could occur if the zipcode or the origin coordinates are not found
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("Failed to find user's location: \(error.localizedDescription)")
    }
    
}