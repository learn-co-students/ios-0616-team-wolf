//
//  Location.swift
//  PlayingWithNYTimesAPI
//
//  Created by Flatiron School on 8/4/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON

class Location {
    var name: String
    var images: [NSURL]
    var description: String
    
    init(apiDictionary: JSON) {
//        guard let
//            keywords = apiDictionary["keywords"] as? NSArray,
//            firstRankKeyword = keywords[0] as? NSDictionary,
//            locationName = firstRankKeyword["value"] as? String,
//            multimedia = apiDictionary["multimedia"] as? NSArray,
//            snippet = apiDictionary["snippet"] as? String
//        else { fatalError("Could not create location object from supplied dictionary.") }
        
        guard let
            locationName = apiDictionary["keywords"][0]["value"].string,
            snippet = apiDictionary["snippet"].string,
            multimedia = apiDictionary["multimedia"].array
            else { fatalError("Could not create location object from supplied dictionary.") }

        
        

        
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
        
        images = []
        name = locationName
        description = snippet
    }
}