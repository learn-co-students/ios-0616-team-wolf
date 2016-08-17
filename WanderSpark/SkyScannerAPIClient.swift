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
    
    typealias FlightCompletion = (Flight, ErrorType?) -> ()
    
    static let store = LocationsDataStore.sharedInstance
    
    class func getFlights(location: Location, completion: FlightCompletion) {
        
        Alamofire.request(.GET, "http://partners.api.skyscanner.net/apiservices/browsequotes/v1.0/US/USD/en-US/40.730610,-73.935242-latlong/\(location.coordinates.0),\(location.coordinates.1)-latlong/anytime/anytime?apikey=\(Secrets.skyscannerAPIKey)").responseJSON { (response) in
            
            if let flightsResponse = response.result.value as? NSDictionary {
                
                guard let
                    flightQuotes = flightsResponse["Quotes"] as? [[String:AnyObject]],
                    locationInfo = flightsResponse["Places"] as? [[String:AnyObject]],
                    carrierList = flightsResponse["Carriers"] as? [[String:AnyObject]]
                    else {
                        fatalError("ERROR: No flights found for location")
                }
                
                //sorting and assigning response to variables/properties
                lowestFlightPrices = flightQuotes.sort{
                    (($0)["MinPrice"] as? Int) < (($1)["MinPrice"] as? Int)
                }
                
                if let cheapestFlight = lowestFlightPrices.first {
                    lowestAirfare = String(cheapestFlight["MinPrice"])
                    if let selectedFlight = cheapestFlight["OutboundLeg"] {
                        bestFlight = selectedFlight as! [String:AnyObject]
                    }
                } else {
                    print("STILL ERROR WITH CHEAPEST FLIGHT")
                }
                
                locationInformation = locationInfo
                carrierInformation = carrierList
                
                print("***************** FLIGHTS *****************")
                print("\n\nNAME: \(location.name)")
                print("FLIGHT: \(bestFlight)")
                print("LOWEST PRICE: \(lowestAirfare)")
                print("LOCATION: \(locationInformation)")
                print("CARRIERS: \(carrierInformation)\n\n")
                print("******************* END *******************")
                
                completion(SkyScannerDataParser.matchedLocationFlightInfo(location), nil)
            } 
            else {
                fatalError("ERROR: No response for flights from \(location.name) with coordinates \(location.coordinates)")
            }
        } //end of Alamofire request
    }//end of class func 
}