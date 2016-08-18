//
//  SkyScannerAPIClient.swift
//  WanderSpark
//
//  Created by Flatiron School on 8/9/16.
//  Copyright © 2016 Zain Nadeem. All rights reserved.
//

import Alamofire
import Foundation
import SwiftyJSON

class SkyScannerAPIClient {
    
    static var lowestFlightPrices = [[String:AnyObject]]()
    static var carrierInformation = [[String:AnyObject]]()
    static var locationInformation = [[String:AnyObject]]()
    static var bestFlight = [String:AnyObject]()
    static var lowestAirfare = ""
    
    enum SkyscannerAPIError: ErrorType {
        case InvalidJSONDictionaryCast
        case InvalidDictionaryResponseKey
        case InvalidDictionaryDocsKey
    }
    
    typealias FlightCompletion = (Flight, ErrorType?) -> ()
    
    static let store = LocationsDataStore.sharedInstance
    
    class func getFlights(location: Location, completion: FlightCompletion) {
        
        guard let coordinates = location.coordinates else { fatalError("ERROR: failed to unwrap coordinate values") }
        
        Alamofire.request(.GET, "http://partners.api.skyscanner.net/apiservices/browsequotes/v1.0/US/USD/en-US/40.730610,-73.935242-latlong/\(coordinates.0),\(coordinates.1)-latlong/anytime/anytime?apikey=\(Secrets.skyscannerAPIKey)").responseJSON { (response) in
            
            var flightQuotes = [[String:AnyObject]]()
            var locationInfo = [[String:AnyObject]]()
            var carrierList = [[String:AnyObject]]()
            
            switch response.result {
                case .Failure(let error):
                    completion(Flight(), error)
                
                case .Success(let value):
                    guard let flightsResponse = value as? NSDictionary else { completion(Flight(), SkyscannerAPIError.InvalidJSONDictionaryCast); return }
                    guard let
                        flightQuotesArray = flightsResponse["Quotes"] as? [[String:AnyObject]],
                        locationInfoArray = flightsResponse["Places"] as? [[String:AnyObject]],
                        carrierListArray = flightsResponse["Carriers"] as? [[String:AnyObject]]
                        else {
                        fatalError("ERROR: No flights found for location")
                        }
                flightQuotes = flightQuotesArray
                locationInfo = locationInfoArray
                carrierList = carrierListArray
                
            }
            
            completion(SkyScannerDataParser.matchedLocationFlightInfo(location, quotes: flightQuotes, carriers: carrierList, airports: locationInfo), nil)
        } //end of Alamofire request
    }//end of class func
}