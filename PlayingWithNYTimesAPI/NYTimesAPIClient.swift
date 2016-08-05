//
//  NYTimesAPIClient.swift
//  PlayingWithNYTimesAPI
//
//  Created by Flatiron School on 8/4/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class NYTimesAPIClient {
    
    class func getLocationsWithCompletion(completion: ([JSON]) -> ()) {
        
        Alamofire.request(.GET, "https://api.nytimes.com/svc/search/v2/articlesearch.json?q=36+Hours&key=\(Secrets.nyTimesAPIKey)")
            .responseJSON { response in
                
                if let responseValue = response.result.value {
                    let json = JSON(responseValue)
                    let docsDictionary = json["response"].dictionaryValue
                    let thirtySixHoursArray = docsDictionary["docs"]!.arrayValue
                    
                    print(thirtySixHoursArray)
                    completion(thirtySixHoursArray)
                
                } else {
                    print("Error casting 36 Hours get request to NSArray.")
                }
        }
    }

}