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
    static var retrievingCoordinates = true
    
    static var flightsRetrieved = false
    static var retrievingFlights = true
    static var numberOfFlightsRetrieved = 0
    
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
                    print("FLIGHT COORDINATES: \(location.name) -> \(location.coordinates)")
                    SkyScannerAPIClient.getFlights(location, completion: {
                        numberOfFlightsRetrieved += 1
                        print("number of flights retrieved: \(String(numberOfFlightsRetrieved))")
                        
                    })
                }
            }
        }
        flightOperation.completionBlock = {
            while numberOfFlightsRetrieved < 10 {
                print("still retrieving flight information")
            }
            
            retrievingFlights = false
            flightsRetrieved = true
            
            for location in self.store.matchedLocations {
                if flightsRetrieved {
                    SkyScannerDataParser.matchedLocationFlightInfo(location)
                    print("***************** FLIGHT INFORMATION *****************")
                    print("\n\nNAME: \(location.name)")
                    print("DESCRIPTION: \(location.description)")
                    print("COORDINATES: \(location.coordinates)")
                    print("CARRIER: \(location.cheapestFlight.carrierName)")
                    print("FLIGHT ORIGIN AIRPORT: \(location.cheapestFlight.originIATACode)")
                    print("PRICE: \(location.cheapestFlight.lowestPrice)\n\n")
                    print("******************* END FLIGHT INFO *******************")
                }

            }
        }
        
        
        googleOperation.addExecutionBlock({
            
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