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
    
    
    func getLocationsWithCompletion(completion: () -> ()) {
        var page = 0
        
        while page < 60 {
            
            NYTimesAPIClient.getLocationsWithCompletion(page) { (thirtySixHoursArray) in

                let parser = NYTimesDataParser()
                
                for article in thirtySixHoursArray {
                    let locationName = parser.getLocationName(article)
                    let locationSnippet = parser.getLocationSnippet(article)
                    let locationImages = parser.getLocationImages(article)

                    print("###############################")
                    print("Name: \(locationName)")
                    print("Description: \(locationSnippet)")
                    print("Images: \(locationImages)")
                    
                    if locationName != "" && !locationImages.isEmpty {
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