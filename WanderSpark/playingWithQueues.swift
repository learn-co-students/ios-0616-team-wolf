//
//  playingWithQueues.swift
//  WanderSpark
//
//  Created by Betty Fung on 8/10/16.
//  Copyright © 2016 Zain Nadeem. All rights reserved.
//

import Foundation

class Operations {
    
    static let store = LocationsDataStore.sharedInstance
    
    // 0. set up main queue for UI stuff
    static let mainOperationQueue = NSOperationQueue.mainQueue()
    
    // 1. load NYTimes location data while user is swiping through survey
    //main thread: swiping
    //function call in the MatchingViewController
    
    //other thread: call NYTimesAPI for every other swipe, use index to determine the call
    class func obtainLocations () {
        let obtainLocations = NSBlockOperation {
            print("locations block called")
            store.getLocationsWithCompletion ({ })
        }
        obtainLocations.qualityOfService = .UserInitiated
        mainOperationQueue.addOperation(obtainLocations)
    }
    
    
    // 3. obtain coordinates for matched locations
    //main thread: loading screen
    //background thread:
    class func obtainCoordinates(matchingComplete: Bool) {
        if matchingComplete {
            GooglePlacesAPIClient.getLocationCoordinatesWithCompletion({ 
                print("getting coordinates!")
            })
        }
    }
    
    //        let obtainLocationCoordinatesQueue = NSOperationQueue()
    //        obtainLocationCoordinatesQueue.qualityOfService = .Utility
    //        if  > 0 /* AND matching thread in step 2 is complete */ {
    //            mainOperationQueue.addOperationWithBlock {
    //                if obtainLocations.finished {
    //                    GooglePlacesAPIClient.getLocationCoordinatesWithCompletion({
    //                    })
    //                }
    //            }
    //        }

    
    // obtainLocationCoordinatesBlockOperation.addDependency(obtainLocationsQueue)
    //        obtainLocationCoordinatesBlockOperation.completionBlock = {
    //            print("in coordinates completion block")
    //            if obtainLocationCoordinatesBlockOperation.finished {
    //                print("DONE WITH COORDINATES QUEUE")
    //            }
    //        }
    
    
    //        mainOperationQueue.addOperations([obtainLocationsQueue, obtainLocationCoordinatesBlockOperation], waitUntilFinished: false)
    
    
    
    // 4. use coordinates for matched locations to get flight information
    //main thread: loading screen
    //other thread: get flight information from skyscannerAPI
    //may need to check if coordinates are already populated first
}