//
//  CoordinateAndFlightQueues.swift
//
//
//  Created by Betty Fung on 8/12/16.
//
//

import Foundation
import Alamofire


class CoordinateAndFlightQueues {
    
    static let store = LocationsDataStore.sharedInstance
    
    static let newOperationQueue = NSOperationQueue()
    static var coordinatesPopulated = false
    static var coordinatesPopulatedCount = 0
    static var retrievingCoordinates : Bool = true
    
    class func getCoordinatesAndFlightInfo () {
        
        print("function called")
        
        let googleOperation = NSBlockOperation()
        googleOperation.addExecutionBlock({
            
            for location in store.matchedLocations {
                 
                GoogleMapsAPIClient.getLocationCoordinatesWithCompletion(location) { (gotCoordinates) in
                    print("********** DESTINATION INFORMATION ************")
                    print("Name: \(location.name)")
                    print("Coordinates: \(location.coordinates)")
                    // print("Flight Price: \(location.cheapestFlight.lowestPrice)")
                    print("Snippet Description: \(location.description)")
                    print("***********************************************")
                    
                    coordinatesPopulatedCount += 1
                }
            }
        })
        

        
        let flightOperation = NSBlockOperation()
        flightOperation.addExecutionBlock {
            if coordinatesPopulated {
                for location in store.matchedLocations {
                    // print("FLIGHT COORDINATES: \(location.name) -> \(location.coordinates)")
                    SkyScannerAPIClient.getPricesForDestination(location, completion: { 
                        print("getting flight info")
                    })
                }
            }
        }
        
        
        googleOperation.addExecutionBlock({
            
            while coordinatesPopulatedCount < 10 {
                print("still retrieving coordinates")
            }
            
            //if progress bar is included on the matching animation screen, may need to hop back onto main queue within these execution and completion blocks to update that bar
            
            retrievingCoordinates = false
            coordinatesPopulated = true
            flightOperation.addDependency(googleOperation)
        })
        
        googleOperation.completionBlock = {
            print("coordinates count: \(coordinatesPopulatedCount)")
        }
        
        newOperationQueue.maxConcurrentOperationCount = 1
        newOperationQueue.addOperations([googleOperation, flightOperation], waitUntilFinished: false)
    }

    
    //    class func getCoordinatesAndFlights() {
    //        if store.matchedLocations.count == 10 {
    //
    //            NSOperationQueue.mainQueue().maxConcurrentOperationCount = 2
    //
    //            let getCoordinates = NSOperationQueue()
    //            getCoordinates.maxConcurrentOperationCount = 1
    //            getCoordinates.addOperationWithBlock({
    //                print("in coordinates queue")
    //                for location in self.store.matchedLocations {
    //                    GooglePlacesAPIClient.getLocationCoordinatesWithCompletion(location, completion: { (gotCoordinates) in
    //
    //                        print("google completion block")
    //                        print("********** DESTINATION INFORMATION ************")
    //                        print("Name: \(location.name)")
    //                        print("Coordinates: \(location.coordinates)")
    //                        // print("Flight Price: \(location.cheapestFlight.lowestPrice)")
    //                        print("Snippet Description: \(location.description)")
    //                        print("***********************************************")
    //
    //                        SkyScannerAPIClient.getPricesForDestination(location, completion: {
    //                            print("flights")
    //                        })
    //                    })
    //                }
    //            })
    //            getCoordinates.qualityOfService = .UserInitiated
    //
    //        }
    //    }
    
    //will need to add queue for loading screen/animation
}