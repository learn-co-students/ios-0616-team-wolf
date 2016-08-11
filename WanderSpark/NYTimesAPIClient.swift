//
//  NYTimesAPIClient.swift
//  PlayingWithNYTimesAPI
//
//  Created by Flatiron School on 8/4/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import Foundation
import Alamofire

struct NYTimesAPIClient {
    
    // Rate limit: Five calls per second, 1k per day allowed.
    
    typealias LocationCompletion = ([Location], ErrorType?) -> ()
    
    enum NYTimesAPIError: ErrorType {
        case InvalidJSONDictionaryCast
        case InvalidDictionaryResponseKey
        case InvalidDictionaryDocsKey
    }
    
    static func getLocationsWithCompletion(page: Int, completion: LocationCompletion) {
        
        Alamofire.request(.GET, "https://api.nytimes.com/svc/search/v2/articlesearch.json?q=36+Hours&page=\(page)&key=\(Secrets.nyTimesAPIKey)")
            .responseJSON { response in
                
                switch response.result {
                case .Failure(let error):
                    completion([Location](), error)
                    
                case .Success(let value):
                    guard let responseValue = value as? NSDictionary else { completion([Location](), NYTimesAPIError.InvalidJSONDictionaryCast); return }
                    
                    guard let docsDictionary = responseValue["response"] as? [String : AnyObject] else { completion([Location](), NYTimesAPIError.InvalidDictionaryResponseKey); return }
                    
                    guard let thirtySixHoursArray = docsDictionary["docs"] as? [[String: AnyObject]] else { completion([Location](), NYTimesAPIError.InvalidDictionaryDocsKey); return }
                    
                    completion(NYTimesDataParser.initializeLocationsFromJSON(thirtySixHoursArray), nil)
                }
        }
    }
}
    /*
    static func getAllPagesWithCompletion(completion: ([[String: AnyObject]]) -> ()) {
        print("Calling get all pages in NYTimes API Client")
        
        var allArticles = [[String: AnyObject]]()
        
        let group = dispatch_group_create()
        let queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
        
        var currentPage = 0
        let lastPage = 20 // We probably want to increase this to get more locations.
        
        repeat {
            let tempPage = currentPage
            print("TempPage: \(tempPage)")
            
            dispatch_group_enter(group)
            dispatch_async(queue, {
                
                self.getLocationsWithCompletion(tempPage, completion: { (thirtySixHoursArray) in
                    print("Array passed from page \(tempPage): \(thirtySixHoursArray)")
                    allArticles.appendContentsOf(thirtySixHoursArray)
                    dispatch_group_leave(group)
                })
            })
            currentPage += 1
        
        } while (currentPage < lastPage)
        
        dispatch_group_notify(group, queue) {
            completion(allArticles)
        }
    }
    */
    
