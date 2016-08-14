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
    
    static let newOperationQueue = NSOperationQueue()
    static var coordinatesPopulated = false
    static var coordinatesPopulatedCount = 0
    static var retrievingCoordinates = true
    
    class func getStuff () {
        
        print("function called")
        
        let googleOperation = NSBlockOperation()
        googleOperation.addExecutionBlock({
            
            for location in store.matchedLocations {
                 
                GooglePlacesAPIClient.getLocationCoordinatesWithCompletion(location) { (gotCoordinates) in
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
        
//        googleOperation.completionBlock = {
//            for location in store.matchedLocations {
//                if location.coordinates != (0.0, 0.0) {
//                    coordinatesPopulatedCount += 1
//                }
//            }
//            
//            
//        }
        
        //        let flightOperation = NSBlockOperation {
        //            for location in store.matchedLocations {
        //                SkyScannerAPIClient.getPricesForDestination(location, completion: {
        //                    print("flights yayay")
        //                })
        //            }
        //        }
        
        let flightOperation = NSBlockOperation()
        flightOperation.addExecutionBlock {
            if coordinatesPopulated {
                for location in store.matchedLocations {
                    print("FLIGHT COORDINATES: \(location.name) -> \(location.coordinates)")
                }
            }
            
        }
        
        googleOperation.addExecutionBlock({
//            print("asynchronous google? \(googleOperation.concurrent)")
            
            while coordinatesPopulatedCount < 10 {
                print("still retrieving coordinates")
            }
            
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