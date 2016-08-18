//
//  NYTimesDataParser.swift
//  WanderSpark
//
//  Created by Flatiron School on 8/8/16.
//  Copyright © 2016 Zain Nadeem. All rights reserved.
//

import Foundation

struct NYTimesDataParser {
    
    static func initializeLocationsFromJSON(JSONArray: [[String : AnyObject]]) -> [Location]? {
        
        var unfilteredLocations : [Location]
        
        for article in JSONArray {
            if let locationName = NYTimesDataParser.getLocationName(article),
            locationSnippet = NYTimesDataParser.getLocationSnippet(article),
            locationImages = NYTimesDataParser.getLocationImages(article),
            articleURL = NYTimesDataParser.getArticleURL(article) {
                
                print("###############################")
                print("Name: \(locationName)")
                print("Description: \(locationSnippet)")
                print("Images: \(locationImages)")
                
                let location = Location(name: locationName, description: locationSnippet, images: locationImages, url: articleURL)
                unfilteredLocations.append(location)
                
            } else {
               print("Error: NYTimesDataParser")
            }
        }
        return unfilteredLocations
    }
    
    
    static func getLocationName(article: [String : AnyObject]) -> String? {
        var locationName : String?
        
        guard let
            headline = article["headline"] as? [String:String],
            keywords = article["keywords"] as? [[String:String]]
            else { print("Error: No location keywords or headline from supplied dictionary.")
                return nil }
        
        // The location name is usually formatted as "City Name (State or Country)" so pull this out by finding keyword with value that contains parentheses substring.
        for keyword in keywords {
            guard let value = keyword["value"] else { print("Error: No value key in keywords dictionary.")
                return nil }
            
            if value.containsString("Civil War") {
                locationName = "Gettysburg (PA)"
            } else if value.containsString("(") {
                locationName = value
            }
        }
        
        // Sometimes the keyword does not include (State or Country), so using parentheses to find  location name does not work. In this case, pull location name from the main headline.
        if locationName == nil {
            guard let mainHeadline = headline["main"] else { print("Error: No main key in headline dictionary.")
                return nil }
            
            if mainHeadline.containsString("36 Hours in") {
                locationName = mainHeadline.stringByReplacingOccurrencesOfString("36 Hours in ", withString: "")
            } else if mainHeadline.containsString("36 Hours:") {
                locationName = mainHeadline.stringByReplacingOccurrencesOfString("36 Hours: ", withString: "")
            }
        }
        return locationName
    }
    
    
    static func getLocationSnippet(article: [String : AnyObject]) -> String? {
        
        if let snippet = article["snippet"] as? String {
            return snippet
        } else {
            print("Could not get location snippet from supplied dictionary.")
            return nil
        }
    }
    
    
    static func getLocationImages(article: [String : AnyObject]) -> [String]? {
        
        guard let multimedia = article["multimedia"] as? [[String: AnyObject]]
            else { print("Could not get location multimedia from supplied dictionary.")
                return nil }
        
        // Replace for-loop with filter for items with type equal to image.
        
        for item in multimedia {
            guard let mediaType = item["type"] as? String else { print("Error: No type key for media item.")
                return nil }
            
            if mediaType == "image" {
                if let imageURL = item["url"] as? String {
                    images.append(imageURL)
                } else {
                    print("Error: Could not get image url from multimedia array.")
                    return nil
                }
            }
        }
        return images
    }
    
    
    static func getArticleURL(article: [String: AnyObject]) -> String? {
        if let url = article["web_url"] as? String {
            return url
        } else {
            print("Error: Could not get article URL from supplied dictionary.")
            return nil
        }
    }
    
}
