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
        var page = 0
        
        while page < 60 {
            NYTimesAPIClient.getLocationsWithCompletion(page) { (thirtySixHoursArray) in
                
                for article in thirtySixHoursArray {
                    
                    guard let
                        keywords = article["keywords"] as? [[String:String]],
                        snippet = article["snippet"] as? String,
                        multimedia = article["multimedia"] as? [[String: AnyObject]]
                        else { print("Could not create location object from supplied dictionary."); return }
                    
                    // There are a variable number of keywords for each article. Iterate over the entire array in order to pull out the one that contains the location name. The location name is always formatted as "City Name (State or Country)" so pull this one out by finding the value that contains parentheses substring.
                    var locationName = ""
                    for keyword in keywords {
                        guard let value = keyword["value"] else { print("Error: No value key in keywords dictionary."); return }
                        if value.containsString("(") {
                            locationName = value
                        }
                    }
                    
                    var images = [String]()
                    for item in multimedia {
                        guard let mediaType = item["type"] as? String else { print("Error: No type key for media item."); return }
                        
                        if mediaType == "image" {
                            guard let imageURL = item["url"] as? String else { print("Error: Failure getting image url from multimedia array."); return }
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
            }
            page += 1
        }
        completion()
    }
}