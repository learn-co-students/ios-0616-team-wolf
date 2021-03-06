//
//  GoogleMapsAPIClient.swift
//  WanderSpark
//
//  Created by Betty Fung on 8/5/16.
//  Copyright © 2016 Zain Nadeem. All rights reserved.
//

import Foundation
import Alamofire

class GoogleMapsAPIClient {
    
    static let store = LocationsDataStore.sharedInstance
    static let sharedUserLocation = UserLocation.sharedInstance
    
    class func getLocationCoordinatesWithCompletion(location: Location, completion: (Bool) -> ()) {
        
        var destinationName = ""
        
        if location.name == "user's zip code" {
            if let zipCode = location.userZipCode {
                destinationName = zipCode
            }
        } else {
            destinationName = Location.formatLocationName(location.name)
        }
        
        print("DESTINATION NAME: \(destinationName)")
        
        Alamofire.request(.GET, "https://maps.googleapis.com/maps/api/geocode/json?address=\(destinationName)&key=\(Secrets.googlePlacesAPIKey)").responseJSON { (response) in
            
            if let locationResultsResponse = response.result.value as? NSDictionary {
                
                guard let
                    locationResults = locationResultsResponse["results"] as? [[String : AnyObject]], //array of location dictionaries
                    destinationInformation = locationResults[0]["geometry"] as? [String:AnyObject], //dictionary of location information
                    destinationLocationInfo = destinationInformation["location"] as? [String : Double], //dictionary of lat/lng info
                    destinationLat = destinationLocationInfo["lat"],
                    destinationLng = destinationLocationInfo["lng"]
                    else {
                        print("ERROR: No match found for submitted location")
                        return
                }
                
                if location.name == "user's zip code" {
                    print("shared user location zip code coordinates: \(self.sharedUserLocation.userZipCodeCoordinates)")
                    self.sharedUserLocation.userZipCodeCoordinates = (destinationLat, destinationLng)
                    print("shared user location zip code coordinates: \(self.sharedUserLocation.userZipCodeCoordinates)")
                } else {
                    location.coordinates = (destinationLat, destinationLng)
                }
                
                print(self.sharedUserLocation.userZipCodeCoordinates)
                completion(true)
                
            } else {
                completion(false)
                print("Failed to get coordinates from Google for zip code")
            }
        }
    }
    
}


