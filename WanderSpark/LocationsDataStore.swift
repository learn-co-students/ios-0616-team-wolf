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
    
    func getLocationsWithCompletion(completion: () -> ()) {
        NYTimesAPIClient.getLocationsWithCompletion { (thirtySixHoursArray) in
            self.locations.removeAll()
            
            for article in thirtySixHoursArray {
                
                guard let
                    keywords = article["keywords"] as? [[String:String]],
                    locationNameOne = keywords[0]["value"],
                    locationNameTwo = keywords[1]["value"],
                    snippet = article["snippet"] as? String,
                    multimedia = article["multimedia"] as? [[String: AnyObject]]
                    else { fatalError("Could not create location object from supplied dictionary.") }
                
                var locationName = locationNameOne
                if locationNameOne == "Travel and Vacations" {
                    locationName = locationNameTwo
                }
                
                print("Name: \(locationName)")
                print("Description: \(snippet)")
                print("##############################")
                
                let location = Location(name: locationName, description: snippet)
                self.locations.append(location)
                print("Location count: \(self.locations.count)")
            }
            completion()
        }
    }
}