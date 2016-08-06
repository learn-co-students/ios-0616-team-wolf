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

//the purpose of using this API is to take the locations provided by the NYTimesAPIClient and find the airport codes within these given locations
//first need to get the placeIDs for these vacation destinations
//then use the types property to filter for airports in these areas


class GooglePlacesAPIClient {
    
    static let vacationDestinations = "Sydney,+Australia"
    //loop through vacation destinations array to replaces spaces with "+"

    class func getLocationCoordinatesWithCompletion(completion: ([String: AnyObject]) -> ()) {
        
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
                
                print("**********DESTINATION INFO HERE***********")
                print(destinationInformation)
                print("latitude: \(destinationLat)")
                print("longitude: \(destinationLng)")
                
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
