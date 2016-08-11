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
    var matchedLocations = [Location(name: "Portland (Me)", description: "", images: []), Location(name: "Budapest (Hungary)", description: "", images: []), Location(name: "Siena (Italy)", description: "", images: [])] //dummy data; ideally, we will have anywhere between 8 to 10 matches for the user
    //var matchedLocations = [Location]()
    
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
                        
                        if !self.locations.contains(location) {
                            self.locations.append(location)
                        }
                        print("Location count: \(self.locations.count)")
                    }
                }
            }
            currentPage += 1
        }
        completion()
    }
    
}