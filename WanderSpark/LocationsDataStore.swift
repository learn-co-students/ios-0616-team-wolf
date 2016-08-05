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
                
                var images = [String]()
                for item in multimedia {
                    guard let mediaType = item["type"] as? String else {print("Error: No type key for media item."); return}
                    
                    if mediaType == "image" {
                        guard let imageURL = item["url"] as? String else {print("Error: Failure getting image url from multimedia array."); return}
                        images.append(imageURL)
                    }
                }
                
                print("Name: \(locationName)")
                print("Description: \(snippet)")
                print("Images: \(images)")
                print("##############################")
                
                let location = Location(name: locationName, description: snippet, images: images)
                self.locations.append(location)
                print("Location count: \(self.locations.count)")
            }
            completion()
        }
    }
}