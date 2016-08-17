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
    
    /*
     switch response.result {
     case .Failure(let error):
     completion([Location](), error)
     
     case .Success(let value):
     guard let responseValue = value as? NSDictionary else { completion([Location](), NYTimesAPIError.InvalidJSONDictionaryCast); return }
     
     guard let docsDictionary = responseValue["response"] as? [String : AnyObject] else { completion([Location](), NYTimesAPIError.InvalidDictionaryResponseKey); return }
     
     guard let thirtySixHoursArray = docsDictionary["docs"] as? [[String: AnyObject]] else { completion([Location](), NYTimesAPIError.InvalidDictionaryDocsKey); return }
     
     completion(NYTimesDataParser.initializeLocationsFromJSON(thirtySixHoursArray), nil)
     } */
    
    class func getFlights(location: Location, completion: FlightCompletion) {
        
        Alamofire.request(.GET, "http://partners.api.skyscanner.net/apiservices/browsequotes/v1.0/US/USD/en-US/40.730610,-73.935242-latlong/\(location.coordinates.0),\(location.coordinates.1)-latlong/anytime/anytime?apikey=\(Secrets.skyscannerAPIKey)").responseJSON { (response) in
            
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
            
//            if let flightsResponse = response.result.value as? NSDictionary {
//                
//                guard let
//                    flightQuotes = flightsResponse["Quotes"] as? [[String:AnyObject]],
//                    locationInfo = flightsResponse["Places"] as? [[String:AnyObject]],
//                    carrierList = flightsResponse["Carriers"] as? [[String:AnyObject]]
//                    else {
//                        fatalError("ERROR: No flights found for location")
//                    }
//                
//                //sorting and assigning response to variables/properties
//                lowestFlightPrices = flightQuotes.sort{
//                    (($0)["MinPrice"] as? Int) < (($1)["MinPrice"] as? Int)
//                }
//            }
            completion(SkyScannerDataParser.matchedLocationFlightInfo(location, quotes: flightQuotes, carriers: carrierList, airports: locationInfo), nil)
        } //end of Alamofire request
    }//end of class func
}
                
//                locationInformation = locationInfo
//                carrierInformation = carrierList
                
//                guard let
////                cheapestFlight = lowestFlightPrices.first,
//                cheapestFlightInfo = cheapestFlight["OutboundLeg"] as? [String:AnyObject]
//                    else {
//                        fatalError()
//                }
                
//                var carrierName = ""
//                var airportInfo = ("", "")
//                
//                if let cheapestFlight = lowestFlightPrices.first {
//                    lowestAirfare = String(cheapestFlight["MinPrice"])
//                    if let selectedFlight = cheapestFlight["OutboundLeg"] as? [String:AnyObject] {
//                        carrierName = SkyScannerDataParser.matchCarrierInformationForFlight(selectedFlight)
//                        airportInfo = SkyScannerDataParser.matchFlightLocationInformationForFlight(selectedFlight)
//                    }
//                } else {
//                    print("STILL ERROR WITH CHEAPEST FLIGHT")
//                }
//                print("***************** FLIGHTS *****************")
//                print("\n\nNAME: \(location.name)")
//                print("FLIGHT: \(bestFlight)")
//                print("LOWEST PRICE: \(lowestAirfare)")
//                print("LOCATION: \(locationInformation)")
//                print("CARRIERS: \(carrierInformation)\n\n")
//                print("******************* END *******************")
                
