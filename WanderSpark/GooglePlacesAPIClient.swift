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
        
            let formattedLocationName = Location.formatLocationName(location.name)
            
            Alamofire.request(.GET, "https://maps.googleapis.com/maps/api/geocode/json?address=\(formattedLocationName)&key=\(Secrets.googlePlacesAPIKey)").responseJSON { (response) in
                
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
                    //update coordinates of location objects before putting them in LocationsDataStore
                    location.coordinates = (destinationLat, destinationLng)
                    
                    print("********** LOCATION INFORMATION ************")
                    print("Name: \(location.name)")
                    print("Formatted Name: \(formattedLocationName)")
                    print("Coordinates: \(location.coordinates)")
                    print("Snippet Description: \(location.description)")
                    print("***********************************************")
                    
                   completion()
                    
                } else {
                    fatalError("ERROR: No response for request")
                }
            }
            // completion()
         }
        //completion()
    }
    
    
    
    // currently using SkyScannerAPI to get flight information based on the coordinates of the origin/destination so we are not using the following function anymore
    
    
    
    //    class func getNearbyAirportsWithCompletion(completion:() ->()) {
    //        //use coordinates obtained from previous function to get nearby airports of vacation destinations
    //
    //        for destination in vacationDestinations {
    //
    //            Alamofire.request(.GET, "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=\(destination.coordinates.latitude),\(destination.coordinates.longitude)&radius=50000&name=airport&type=airport&key=\(Secrets.googlePlacesAPIKey)").responseJSON(completionHandler: { (response) in
    //
    //                if let nearbyAirportsResponse = response.result.value as? NSDictionary {
    //
    //                    guard let airportResults = nearbyAirportsResponse["results"] as? [[String:AnyObject]]
    //                        else {
    //                            fatalError("ERROR: No airports found nearby given location")
    //                    }
    //
    //                    //current problem: some airport names aren't in english, some terminals are being added as airports (Paris), and others are outside of radius allowed by google (Ex: Barcelona), its status is "ZERO_RESULTS"
    //                    //there's also redundancy in the print statement of airport information and in some, like South Africa, airport information is empty until the end (after a few repeated prints with no airport information)
    //
    //                    destination.nearbyAirports.removeAll()
    //
    //                    for airportResult in airportResults {
    //                        if let currentAirport = airportResult["name"] as? String {
    //                            let airport = Airport(airportName: currentAirport)
    //                            destination.nearbyAirports.append(airport)
    //                        }
    //                    }
    //
    //                    completion()
    //                } else {
    //                    fatalError("ERROR: No response for nearbyAirports request")
    //                }
    //
    //                print("********** AIRPORT INFORMATION ************")
    //                print("Location: \(destination.name)")
    //                print("Location Coordinates: \(destination.coordinates.0),\(destination.coordinates.1)")
    //                for airport in destination.nearbyAirports {
    //                    print("Airport: \(airport.airportName)")
    //                }
    //                print("*******************************************")
    //
    //            })
    //        }
    //
    //    } //end of function
}
