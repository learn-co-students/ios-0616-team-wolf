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
            
            let coordinateOperation = NSBlockOperation {
                GooglePlacesAPIClient.getLocationCoordinatesWithCompletion {
                    print("got coordinates")
                }
            }
            coordinateOperation.qualityOfService = .UserInitiated
            
        
            
            
            let flightPriceOperation = NSBlockOperation {
                for location in store.matchedLocations {
                    SkyScannerAPIClient.getPricesForDestination(location, completion: { 
                        print("got prices")
                    })
                }
            }
            flightPriceOperation.addDependency(coordinateOperation)
            
            let printCompleteInfoOperation = NSBlockOperation {
                print("flights complete")
                for location in store.matchedLocations {
                    print("********** DESTINATION INFORMATION ************")
                    print("Name: \(location.name)")
                    print("Coordinates: \(location.coordinates)")
                    // print("Flight Price: \(location.cheapestFlight.lowestPrice)")
                    print("Snippet Description: \(location.description)")
                    print("***********************************************")
                }
            }
            printCompleteInfoOperation.addDependency(flightPriceOperation)
            printCompleteInfoOperation.addDependency(coordinateOperation)
            printCompleteInfoOperation.qualityOfService = .Utility
            
            NSOperationQueue.mainQueue().addOperations([coordinateOperation, flightPriceOperation, printCompleteInfoOperation], waitUntilFinished: false)


        }
    }
    
    
    //flight queue
    
}