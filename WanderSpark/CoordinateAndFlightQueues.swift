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
    
    class func getCoordinatesAndFlightInfo (completion: (Bool)-> ()) {
        
        let googleOperation = NSBlockOperation()
        googleOperation.addExecutionBlock({
            
            for location in store.matchedLocations {
                 
                GoogleMapsAPIClient.getLocationCoordinatesWithCompletion(location) { (gotCoordinates) in
                    print("********** DESTINATION INFORMATION ************")
                    print("Name: \(location.name)")
                    print("Coordinates: \(location.coordinates)")
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
                    SkyScannerAPIClient.getFlights(location, completion: {_,_ in
                        numberOfFlightsRetrieved += 1
                        print("number of flights retrieved: \(String(numberOfFlightsRetrieved))")
                        
                        //double check flight information here to see if it has been properly populated, if not add it to an array and then loop through it again!! 
                        
                        Flight.printFlightInformation(location)

                    })
                }
            }
        }
        
        flightOperation.addExecutionBlock {
            while numberOfFlightsRetrieved < 10 {
                print("still retrieving flight information")
                //make sure animation keeps going here and then remove print statement 
            }
            
            retrievingFlights = false
            flightsRetrieved = true
        }
        
        flightOperation.completionBlock = {
            if flightsRetrieved {
                print("all flight info retrieved")
                NSOperationQueue.mainQueue().addOperationWithBlock({ 
                    completion(true)
                })
                
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

}