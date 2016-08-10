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
    let name: String
    let images: [String]
    let description: String
    var matchCount = 0
    var coordinates: (latitude: Double, longitude: Double)

    
    init(name: String, description: String, images: [String], coordinates: (Double, Double)) {
        self.name = name
        self.description = description
        self.images = images
        self.coordinates = coordinates
    }
    
    convenience init(name: String, description: String, images: [String]){
        self.init(name: name, description: description, images: images, coordinates: (0.00, 0.00))
    }
    
    
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