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
        for article in thirtySixHoursArray {
            guard let snippet = article["snippet"] as? String
                else { assertionFailure("Could not create location object from supplied dictionary.") }
        }
        return snippet  
    }
    
    
    func getLocationImages() -> [String] {
        
        for article in thirtySixHoursArray {
            guard let
                multimedia = article["multimedia"] as? [[String: AnyObject]]
                else { print("Could not create location object from supplied dictionary."); return }
        var images = [String]()
        for item in multimedia {
            guard let mediaType = item["type"] as? String else { print("Error: No type key for media item."); return }
            
            if mediaType == "image" {
                guard let imageURL = item["url"] as? String else { print("Error: Failure getting image url from multimedia array."); return }
                images.append(imageURL)
            }
        }
    }
}
