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
            
            for json in thirtySixHoursArray {
                
//                guard let locationDictionary = json.dictionaryValue as? [String: AnyObject] else { fatalError("Object in thirtySixHoursArray is of non-dictionary type.") }
                let location = Location(apiDictionary: json)
                self.locations.append(location)
            }
            
            completion()
        }
    }
}