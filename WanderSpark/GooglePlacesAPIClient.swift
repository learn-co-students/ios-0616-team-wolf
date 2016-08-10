//
//  GooglePlacesAPIClient.swift
//  WanderSpark
//
//  Created by Betty Fung on 8/5/16.
//  Copyright © 2016 Zain Nadeem. All rights reserved.
//

import Foundation
import Alamofire

class GooglePlacesAPIClient {
    
    static let store = LocationsDataStore.sharedInstance
    
    class func getLocationCoordinatesWithCompletion(completion: () -> ()) {
        
        print("in google coordinates function...")
        
        for location in store.matchedLocations {
            
            print("HELLO, I'M IN THE LOOP YAY")
            
            let destinationName = Location.formatLocationName(destination.name)
            
            Alamofire.request(.GET, "https://maps.googleapis.com/maps/api/geocode/json?address=\(destinationName)&key=\(Secrets.googlePlacesAPIKey)").responseJSON { (response) in
                
                if let locationResultsResponse = response.result.value as? NSDictionary {
                    
                    guard let
                        locationResults = locationResultsResponse["results"] as? [[String : AnyObject]], //array of location dictionaries
                        destinationInformation = locationResults[0]["geometry"] as? [String:AnyObject], //dictionary of location information
                        destinationLocationInfo = destinationInformation["location"] as? [String : Double], //dictionary of lat/lng info
                        destinationLat = destinationLocationInfo["lat"],
                        destinationLng = destinationLocationInfo["lng"]
                        else {
                            fatalError("ERROR: No match found for submitted location")
                    }
                    //input coordinates to location objects in LocationsDataStore
                    destination.coordinates = (destinationLat, destinationLng)
                    
                    print("********** DESTINATION INFORMATION ************")
                    print("Name: \(destination.name)")
                    print("Formatted Name: \(destinationName)")
                    print("Coordinates: \(destination.coordinates)")
                    print("Snippet Description: \(destination.description)")
                    print("***********************************************")
                    
                    completion()
                    
                } else {
                    fatalError("ERROR: No response for request")
                }
            }
        }
    }
}

