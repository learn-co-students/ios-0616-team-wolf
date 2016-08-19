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
        let lastPage = 5
        
        while currentPage < lastPage {
            
            print("OUTSIDE CALL ---- CURRENT PAGE: \(currentPage)")
            
            NYTimesAPIClient.getLocationsWithCompletion(currentPage) { (locationCompletion) in
                
                print("INSIDE CALL ---- CURRENT PAGE: \(currentPage)")
                
                for location in locationCompletion.0 {
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