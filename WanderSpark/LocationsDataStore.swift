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
    var matchedLocations = [Location(name: "Portland (Me)", description: "", images: [], url: ""), Location(name: "Budapest (Hungary)", description: "", images: [], url: ""), Location(name: "Siena (Italy)", description: "", images: [], url: "")] //dummy data; ideally, we will have anywhere between 8 to 10 matches for the user
    // var matchedLocations = [Location]()
    
    func getLocationsWithCompletion(completion: () -> ()) {
        
        var currentPage = 0
        let lastPage = 5
        
        while currentPage < lastPage {
            
            NYTimesAPIClient.getLocationsWithCompletion(currentPage) { (locationCompletion) in
                
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