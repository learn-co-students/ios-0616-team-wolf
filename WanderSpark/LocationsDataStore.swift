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
            
            NYTimesAPIClient.getAllPagesWithCompletion { (thirtySixHoursArray) in
                print(thirtySixHoursArray)
                
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
        completion()
    }
    
}