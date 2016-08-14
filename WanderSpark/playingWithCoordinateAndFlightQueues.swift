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
    
    class func getCoordinatesAndFlights() {
        if store.matchedLocations.count == 10 {
            
            NSOperationQueue.mainQueue().maxConcurrentOperationCount = 2
            
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

        }
    }
    
    //will need to add queue for loading screen/animation
}