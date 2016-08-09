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
    var airports = [Airport]()
    
    //placeholder, will be changed to user's input later
    var usersCurrentLocation = "New York, NY"
    
    
    func getLocationsWithCompletion(completion: () -> ()) {
        
        var page = 0
        
        while page < 60 {
            
            NYTimesAPIClient.getLocationsWithCompletion(page) { (thirtySixHoursArray) in

                let parser = NYTimesDataParser()
                
                for article in thirtySixHoursArray {
                    let locationName = parser.getLocationName(article)
                    let locationSnippet = parser.getLocationSnippet(article)
                    let locationImages = parser.getLocationImages(article)

                    print("Name: \(locationName)")
                    print("Description: \(locationSnippet)")
                    print("Images: \(locationImages)")
                    print("##############################")
                    
                    if locationName != "" {
                        let location = Location(name: locationName, description: locationSnippet, images: locationImages)
                        self.locations.append(location)
                        print("Location count: \(self.locations.count)")
                    }
                }
            }
            page += 1  
        }
        completion()
    }
    
}