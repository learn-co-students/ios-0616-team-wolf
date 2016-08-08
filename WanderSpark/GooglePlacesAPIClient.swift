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
    
    static let locationsStore = LocationsDataStore.sharedInstance
    static var vacationDestinations = locationsStore.locations
    //static var destinationAirports = locationsStore.airports
    
    //need to get coordinates before searching nearby airports
    class func getLocationCoordinatesWithCompletion(completion: () -> ()) {
        
        for destination in self.vacationDestinations {
            
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
                    
                    completion(self.getNearbyAirportsWithCompletion({ 
                        //call function when this is done adding coordinates to locations
                    }))
                    
                } else {
                    fatalError("ERROR: No response for request")
                }
                
            }
        }
    }
    
    class func getNearbyAirportsWithCompletion(completion:() ->()) {
        //use coordinates obtained from previous function to get nearby airports of vacation destinations
        
       for destination in vacationDestinations {
            
            Alamofire.request(.GET, "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=\(destination.coordinates.latitude),\(destination.coordinates.longitude)&radius=50000&name=airport&type=airport&key=\(Secrets.googlePlacesAPIKey)").responseJSON(completionHandler: { (response) in
                
                if let nearbyAirportsResponse = response.result.value as? NSDictionary {
                    
                    guard let airportResults = nearbyAirportsResponse["results"] as? [[String:AnyObject]]
                        else {
                            fatalError("ERROR: No airports found nearby given location")
                    }
                    
                    destination.nearbyAirports.removeAll()
                    
                    for airportResult in airportResults {
                        if let currentAirport = airportResult["name"] as? String {
                            let airport = Airport(airportName: currentAirport)
                            destination.nearbyAirports.append(airport)
                        }
                    }
                    
                    print("********** AIRPORT INFORMATION ************")
                    print("Location: \(destination.name)")
                    print("Location Coordinates: \(destination.coordinates.0),\(destination.coordinates.1)")
                    for airport in destination.nearbyAirports {
                        print("Airport: \(airport.airportName)")
                    }
                    print("*******************************************")
                    
                    completion()
                } else {
                    fatalError("ERROR: No response for nearbyAirports request")
                }
            })
            
        }
        
    } //end of function
}