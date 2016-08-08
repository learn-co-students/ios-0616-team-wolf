//
//  Location.swift
//  PlayingWithNYTimesAPI
//
//  Created by Flatiron School on 8/4/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import Foundation
import UIKit

class Location {
    var name: String
    var images: [NSURL]
    var description: String
    var coordinates: (latitude: Double, longitude: Double)
    var nearbyAirports: [Airport]
    
    init(name: String, description: String, coordinates: (Double, Double), nearbyAirports: [Airport]) {
        self.name = name
        self.description = description
        self.images = []
        self.coordinates = coordinates
        self.nearbyAirports = nearbyAirports
        
        // Attempt to get images from the multimedia array:
        
        //        for item in multimedia  {
        //            guard let item = item as? NSDictionary else {
        //                fatalError("Could not get multimedia dictionary.")
        //            }
        //            if item["type"] == "image" {
        //                guard let imageURL = item["url"] as? NSURL else {
        //                    fatalError("Could not get image URL from supplied dictionary.")
        //                }
        //                images.append(imageURL)
        //            }
        //        }
        
    }
    
    
    convenience init(name: String, description: String) {
        self.init(name: name, description: description, coordinates: (0.00, 0.00), nearbyAirports: [Airport(airportName: "DEFAULT 1"), Airport(airportName: "DEFAULT 2")])
    }
    
//    convenience init(name: String, description: String, coordinates: (Double, Double)){
//        
//    }
    
    class func formatLocationName(locationName: String) -> String {
        //place comma between city and state/country
        let locationNameArray = locationName.componentsSeparatedByString(" (")
        let addCommaToLocationName = locationNameArray.joinWithSeparator(",")
        
        //remove parenthesis and replace spaces with "+"
        var formattedLocation = addCommaToLocationName.stringByReplacingOccurrencesOfString(")", withString: "")
        formattedLocation = formattedLocation.stringByReplacingOccurrencesOfString(" ", withString: "+")
        
        return formattedLocation
    }
}