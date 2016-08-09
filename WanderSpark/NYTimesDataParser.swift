//
//  NYTimesDataParser.swift
//  WanderSpark
//
//  Created by Flatiron School on 8/8/16.
//  Copyright © 2016 Zain Nadeem. All rights reserved.
//

import Foundation

class NYTimesDataParser {
    
    let thirtySixHoursArray = [[String : AnyObject]]()
//    var headline = [String:String]()
//    var keywords = [[String:String]]()
//    var multimedia = [[String: AnyObject]]()
   
    func unwrapOptionalLocationData() {
        for article in thirtySixHoursArray {
            guard let
                headline = article["headline"] as? [String:String],
                keywords = article["keywords"] as? [[String:String]],
                snippet = article["snippet"] as? String,
                multimedia = article["multimedia"] as? [[String: AnyObject]]
                else { print("Could not create location object from supplied dictionary."); return }
        }
    }
    
    
    func getLocationName() -> String {
        var locationName = ""
        
        for article in thirtySixHoursArray {
            guard let
                headline = article["headline"] as? [String:String],
                keywords = article["keywords"] as? [[String:String]]
                else { assertionFailure("Could not get location keywords or headline from supplied dictionary.") }
            
            // The location name is usually formatted as "City Name (State or Country)" so pull this out by finding keyword with value that contains parentheses substring.
            
            for keyword in keywords {
                guard let value = keyword["value"] else { assertionFailure("Error: No value key in keywords dictionary.") }
                if value.containsString("(") {
                    locationName = value
                }
            }
            
            // Sometimes the keyword does not include (State or Country), so using parentheses to find  location name does not work. In this case, pull location name from the main headline.
            if locationName == "" {
                guard let mainHeadline = headline["main"] else { assertionFailure("Error: No main key in headline dictionary.") }
                if mainHeadline.containsString("36 Hours in") {
                    locationName = mainHeadline.stringByReplacingOccurrencesOfString("36 Hours in ", withString: "")
                } else if mainHeadline.containsString("36 Hours:") {
                    locationName = mainHeadline.stringByReplacingOccurrencesOfString("36 Hours: ", withString: "")
                }
            }
        }
        return locationName
    }
    
    
    func getLocationSnippet() -> String {
        
    }
    
    
    func getLocationImages() -> [String] {
        
    }
}
