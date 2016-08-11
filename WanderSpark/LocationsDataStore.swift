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
    
    
    func getLocationsWithCompletion(completion: () -> ()) {
        
        var currentPage = 0
        let lastPage = 10
        
        while currentPage < lastPage {
            
            NYTimesAPIClient.getLocationsWithCompletion(currentPage) { (thirtySixHoursArray) in
                
                let unfilteredLocations = NYTimesDataParser.initializeLocationsFromJSON(thirtySixHoursArray)
                
                for location in unfilteredLocations {
                    if !self.locations.contains(location) {
                        self.locations.append(location)
                    }
                    print("Location count: \(self.locations.count)")
                }
            }
            currentPage += 1
        }
        completion()
    }
    
}