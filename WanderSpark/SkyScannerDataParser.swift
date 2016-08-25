//
//  SkyScannerDataParser.swift
//  WanderSpark
//
//  Created by Betty Fung on 8/16/16.
//  Copyright © 2016 Zain Nadeem. All rights reserved.
//

import Foundation
import Alamofire


class SkyScannerDataParser {
    
    static let store = LocationsDataStore.sharedInstance
    
    static var cheapestFlight = [String : AnyObject]()
    
    static var flightCarrierID = 0
    static var flightCarrierName : String = ""
    static var flightOriginIATACode : String = ""
    static var flightOriginName : String = ""
    static var flightDestinationIATACode : String = ""
    static var flightDestinationName : String = ""
    static var lowestAirfare : Int = 0
    
    static var flightCarrierIDArrayTest = [String]()
    
    class func getMinimumPrice(quotes: [[String: AnyObject]]) -> Int {
        var minimumPrice = 0
        
        let lowestFlightPrices = quotes.sort{
            (($0)["MinPrice"] as? Int) < (($1)["MinPrice"] as? Int)
        }
        
        if let lowestAirfare = lowestFlightPrices.first {
            cheapestFlight = lowestAirfare
        }
        
        
        if let unwrappedMinimumPrice = cheapestFlight["MinPrice"] as? Int {
            minimumPrice = unwrappedMinimumPrice
        } else {
            print("ERROR WITH CHEAPEST FLIGHT")
        }
        return minimumPrice
    }
    
    
    class func getCarrierInfo(quotes: [[String:AnyObject]], carriers: [[String:AnyObject]]) -> (Int, String) {
        var outboundCarrierID = 0
        var outboundCarrierName = ""
        
        if let outboundFlight = cheapestFlight["OutboundLeg"] as? [String:AnyObject] {
            
            guard let
                outboundCarriers = outboundFlight["CarrierIds"] as? [Int]
                else {print("ERROR: no carrierID for best flight"); return (0, "error")}
            
            if let firstCarrierID = outboundCarriers.first {
                outboundCarrierID = firstCarrierID
            }
        
            for carrier in carriers {
                
                guard let carrierID = carrier["CarrierId"] as? Int
                    else {print("no carrier IDs available"); return (0, "error")}
                
                if outboundCarrierID == carrierID {
                    outboundCarrierName = carrier["Name"] as! String
                }
            }
        } else {
            print("ERROR WITH CARRIER ID")
        }
        return (outboundCarrierID, outboundCarrierName)
    }


    class func getAirportInfo(quotes: [[String:AnyObject]], airports: [[String : AnyObject]]) -> (String, String){
        
        if let outboundFlight = cheapestFlight["OutboundLeg"] as? [String:AnyObject] {
            
            guard let
                flightOriginID = outboundFlight["OriginId"] as? Int,
                flightDestinationID = outboundFlight["DestinationId"] as? Int
                else { print("no airport name/IATA code available"); return ("error", "no airport information available") }
            
            for airport in airports {
                
                guard let
                    airportName = airport["Name"] as? String,
                    airportIATACode = airport["IataCode"] as? String
                    else { print("no airport name/IATA code available"); return ("error", "no airport information available") }
                
                if airport["PlaceId"] as? Int == flightOriginID {
                    flightOriginName = airportName
                    flightOriginIATACode = airportIATACode
                }
                else if airport["PlaceId"] as? Int == flightDestinationID {
                    flightDestinationName = airportName
                    flightDestinationIATACode = airportIATACode
                }
            }
        }
        return (flightOriginIATACode, flightOriginName)
    }
    
    
    
    class func matchedLocationFlightInfo(location: Location, quotes: [[String : AnyObject]], carriers: [[String : AnyObject]], airports: [[String : AnyObject]]) -> Flight {
        
        let minimumPrice = String(getMinimumPrice(quotes))
        let carrierInfo = getCarrierInfo(quotes, carriers: carriers)
        let airportInfo = getAirportInfo(quotes, airports: airports)
        
        let cheapestFlight = Flight(carrierName: carrierInfo.1, carrierID: carrierInfo.0, originIATACode: airportInfo.0, destinationIATACode: airportInfo.1, lowestPrice: minimumPrice)
        location.cheapestFlight = cheapestFlight
        return cheapestFlight
    }
}



