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
                
                for article in thirtySixHoursArray {
                    let locationName = NYTimesDataParser.getLocationName(article)
                    let locationSnippet = NYTimesDataParser.getLocationSnippet(article)
                    let locationImages = NYTimesDataParser.getLocationImages(article)
                    
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
            currentPage += 1
        }
        completion()
    }
    
}