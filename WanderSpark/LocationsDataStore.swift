//
//  LocationsDataStore.swift
//  PlayingWithNYTimesAPI
//
//  Created by Flatiron School on 8/4/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import Foundation

class LocationsDataStore {
    
    static let sharedInstance = LocationsDataStore()
    private init() {}
    
    var locations = [Location]()
    var matchedLocations = [Location]()
    
    var locationsRetrieved = false
    var retrievingLocations = true
    
    let newOperationQueue = NSOperationQueue()
    
    func getLocationsWithCompletion(completion: () -> ()) {
        
        let NYTimesOperationOne = NSBlockOperation()
        addExecutionBlock(NYTimesOperationOne)
        
        let NYTimesOperationTwo = NSBlockOperation()
        addExecutionBlock(NYTimesOperationTwo)
        
        let NYTimesOperationThree = NSBlockOperation()
        addExecutionBlock(NYTimesOperationThree)
        
        let NYTimesOperationFour = NSBlockOperation()
        addExecutionBlock(NYTimesOperationFour)
        
        let NYTimesOperationFive = NSBlockOperation()
        addExecutionBlock(NYTimesOperationFive)
        
        let NYTimesOperationSix = NSBlockOperation()
        addExecutionBlock(NYTimesOperationSix)
        
        let NYTimesOperationSeven = NSBlockOperation()
        addExecutionBlock(NYTimesOperationSeven)
        
        let NYTimesOperationEight = NSBlockOperation()
        addExecutionBlock(NYTimesOperationEight)
        
        let NYTimesOperationNine = NSBlockOperation()
        addExecutionBlock(NYTimesOperationNine)
        
        let NYTimesOperationTen = NSBlockOperation()
        addExecutionBlock(NYTimesOperationTen)

        completion()
        
        newOperationQueue.addOperations([NYTimesOperationOne, NYTimesOperationTwo, NYTimesOperationThree, NYTimesOperationFour, NYTimesOperationFive, NYTimesOperationSix, NYTimesOperationSeven, NYTimesOperationEight, NYTimesOperationNine, NYTimesOperationTen], waitUntilFinished: false)
    }
    
    func addExecutionBlock(NYTimesOperation: NSBlockOperation) {
        NYTimesOperation.addExecutionBlock({
            let page = Int(arc4random_uniform(10))
            print("This is the randomly selected page: \(page)")
            
            NYTimesAPIClient.getLocationsWithCompletion(page, completion: { (locationCompletion) in
                print("This is the page requested from NYTimes: \(page)")
                
                for location in locationCompletion.0 {
                    if !self.locations.contains(location) {
                        self.locations.append(location)
                    }
                    print("Location count: \(self.locations.count)")
                }
            })
        })
    }
    
    
}