//
//  GooglePlacesAPIClient.swift
//  WanderSpark
//
//  Created by Betty Fung on 8/5/16.
//  Copyright © 2016 Zain Nadeem. All rights reserved.
//

import Foundation
import Alamofire
import GooglePlaces
import GooglePlacePicker
import GoogleMaps

class GooglePlacesAPIClient {
    
    static let vacationDestinations = "Sydney,+Australia"
    //loop through vacation destinations array to replaces spaces with "+"
    static var locationCoordinates = [(Double,Double)]()

    //need to have location coordinates to find nearby airports
    class func getLocationCoordinatesWithCompletion(completion: () -> ()) {
        
        Alamofire.request(.GET, "https://maps.googleapis.com/maps/api/geocode/json?address=\(self.vacationDestinations)&key=\(Secrets.googlePlacesAPIKey)").responseJSON { (response) in
            
            print("inside request")
            
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
                
                let coordinates = (destinationLat, destinationLng)
                
                print("**********DESTINATION INFO HERE***********")
                print(destinationInformation)
                print("coordinates: \(coordinates)")
                
                self.locationCoordinates.append(coordinates)
                
                completion()
                
            } else {
                fatalError("ERROR: No response for request")
            }
            
        }
    }
    
    class func getNearbyAirports() {
        //use coordinates obtained from previous function to get nearby airports
    }
    
    class func obtainAirportCodes() -> [String] {
        //get codes of nearby airports from IATA API to pass into QPX Express API and get flight information
        return [" "]
    }
    
}
