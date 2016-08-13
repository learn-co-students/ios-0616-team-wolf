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
    let articleURL: String
    var matchCount = 0
    var coordinates : (Double, Double)!
    // var cheapestFlight : Flight!
    
    init(name: String, description: String, images: [String], url: String) {
        self.name = name
        self.description = description
        self.images = images
        self.articleURL = url
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

extension Location: Equatable {}
    func ==(lhs: Location, rhs: Location) -> Bool {
        return lhs.articleURL == rhs.articleURL
    }
