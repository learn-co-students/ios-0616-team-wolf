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
            
            let getCoordinates = NSOperationQueue()
            getCoordinates.addOperationWithBlock({
                GooglePlacesAPIClient.getLocationCoordinatesWithCompletion({ (addedCoordinates) in
                    
                    print("Added Coordinates? \(addedCoordinates)")
                    NSOperationQueue.mainQueue().addOperationWithBlock({
                        Testing.testingStuff()
                    })
                })
            })
            getCoordinates.maxConcurrentOperationCount = 1
            getCoordinates.qualityOfService = .UserInitiated

            
            
            
            let flightPriceOperation = NSOperationQueue()
            flightPriceOperation.maxConcurrentOperationCount = 1
            flightPriceOperation.addOperationWithBlock({ 
                for location in store.matchedLocations {
                    print("flyyyyyyyyyy")
                    print("Location coordinates: \(location.coordinates)")
                }
            })
            NSOperationQueue.mainQueue().addOperationWithBlock({ 
                flightPriceOperation
                print("calling flights")
            })
        }
    }
}