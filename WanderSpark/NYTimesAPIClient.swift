//
//  NYTimesAPIClient.swift
//  PlayingWithNYTimesAPI
//
//  Created by Flatiron School on 8/4/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import Foundation
import Alamofire

class NYTimesAPIClient {
    
    // Notes on rate limit: Five calls per second allowed. Maybe implement a timer so that this follows the rate limit otherwise we won't get all the data we need? Or, request 5 pages each time that a new question view controller is presented?
    
    class func getLocationsWithCompletion(page: Int, completion: ([[String: AnyObject]]) -> ()) {
        
        Alamofire.request(.GET, "https://api.nytimes.com/svc/search/v2/articlesearch.json?q=36+Hours&page=\(page)&key=\(Secrets.nyTimesAPIKey)")
            .responseJSON { response in
                
                if let responseValue = response.result.value as? NSDictionary {
                    
                    guard let docsDictionary = responseValue["response"] as? [String : AnyObject] else {
                        print("Error: Unable to get docs dictionary from NYTimes response value.")
                        return
                    }
                    guard let thirtySixHoursArray = docsDictionary["docs"] as? [[String: AnyObject]] else {
                        print ("Error: Unable to get 36 Hours articles array from docs dictionary.")
                        return
                    }
                    completion(thirtySixHoursArray)
                    
                } else {
                    print("Error: Unable to get response value from NYTimes get request.")
                }
        }
    }
    
}