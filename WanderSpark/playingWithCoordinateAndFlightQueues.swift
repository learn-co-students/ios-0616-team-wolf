//
//  playingWithCoordinateAndFlightQueues.swift
//
//
//  Created by Betty Fung on 8/12/16.
//
//

import Foundation
import Alamofire


class CoordinateAndFlightQueues {
    
    static let store = LocationsDataStore.sharedInstance
    
    //coordinate operation
    class func getCoordinatesAndFlights() {
        if store.matchedLocations.count == 10 {
            
            NSOperationQueue.mainQueue().maxConcurrentOperationCount = 1
            
            let getCoordinates = NSOperationQueue()
            getCoordinates.maxConcurrentOperationCount = 1
            getCoordinates.addOperationWithBlock({
                print("in coordinates queue")
                for location in self.store.matchedLocations {
                    GooglePlacesAPIClient.getLocationCoordinatesWithCompletion(location, completion: { (gotCoordinates) in
                        
                        print("google completion block")
                        print("********** DESTINATION INFORMATION ************")
                        print("Name: \(location.name)")
                        print("Coordinates: \(location.coordinates)")
                        // print("Flight Price: \(location.cheapestFlight.lowestPrice)")
                        print("Snippet Description: \(location.description)")
                        print("***********************************************")
                        
                        SkyScannerAPIClient.getPricesForDestination(location, completion: {
                            print("flights")
                        })
                    })
                }
            })
            getCoordinates.qualityOfService = .UserInitiated
            NSOperationQueue.mainQueue().addOperationWithBlock({
                print("added coordinates queue")
                getCoordinates
            })

        }
    }
}