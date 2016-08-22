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
        addExecutionBlock(NYTimesOperationOne, page: 0)
        
        let NYTimesOperationTwo = NSBlockOperation()
        addExecutionBlock(NYTimesOperationTwo, page: 1)
        
        let NYTimesOperationThree = NSBlockOperation()
        addExecutionBlock(NYTimesOperationThree, page: 2)
        
        let NYTimesOperationFour = NSBlockOperation()
        addExecutionBlock(NYTimesOperationFour, page: 3)
        
        let NYTimesOperationFive = NSBlockOperation()
        addExecutionBlock(NYTimesOperationFive, page: 4)
        
        let NYTimesOperationSix = NSBlockOperation()
        addExecutionBlock(NYTimesOperationSix, page: 5)
        
        let NYTimesOperationSeven = NSBlockOperation()
        addExecutionBlock(NYTimesOperationSeven, page: 6)
        
        let NYTimesOperationEight = NSBlockOperation()
        addExecutionBlock(NYTimesOperationEight, page: 7)
        
        let NYTimesOperationNine = NSBlockOperation()
        addExecutionBlock(NYTimesOperationNine, page: 8)
        
        let NYTimesOperationTen = NSBlockOperation()
        addExecutionBlock(NYTimesOperationTen, page: 9)

        completion()
        
        newOperationQueue.maxConcurrentOperationCount = 2
        
        newOperationQueue.addOperations([NYTimesOperationOne, NYTimesOperationTwo, NYTimesOperationThree, NYTimesOperationFour, NYTimesOperationFive, NYTimesOperationSix, NYTimesOperationSeven, NYTimesOperationEight, NYTimesOperationNine, NYTimesOperationTen], waitUntilFinished: false)
    }
    
    func addExecutionBlock(NYTimesOperation: NSBlockOperation, page: Int) {
        NYTimesOperation.addExecutionBlock({
            //let page = Int(arc4random_uniform(10))
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