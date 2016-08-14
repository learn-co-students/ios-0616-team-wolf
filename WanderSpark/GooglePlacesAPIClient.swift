//
//  GooglePlacesAPIClient.swift
//  WanderSpark
//
//  Created by Betty Fung on 8/5/16.
//  Copyright © 2016 Zain Nadeem. All rights reserved.
//

import Foundation
import Alamofire

class GooglePlacesAPIClient : NSBlockOperation {
    
    static let store = LocationsDataStore.sharedInstance
    
    class func getLocationCoordinatesWithCompletion(location: Location, completion: (Bool) -> ()) {
        
        print("HELLO, I'M IN GOOGLE API CLIENT")
        
        let destinationName = Location.formatLocationName(location.name)
        
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
                
                location.coordinates = (destinationLat, destinationLng)
                
                completion(true)
                
            } else {
                fatalError("ERROR: No response for request")
            }
        }
    }
    
}


