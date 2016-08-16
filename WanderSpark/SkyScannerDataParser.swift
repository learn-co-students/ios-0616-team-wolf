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
    
    static var flightCarrierID = 0
    static var flightCarrierName : String = ""
    static var flightOriginIATACode : String = ""
    static var flightOriginName : String = ""
    static var flightDestinationIATACode : String = ""
    static var flightDestinationName : String = ""
    static var lowestAirfare : Int = 0
    
    
    class func matchCarrierInformation() {
        
        for carrier in SkyScannerAPIClient.carrierInformation {
            
            guard let
                flightData = SkyScannerAPIClient.lowestPrices[0] as? [String: AnyObject],
                flightCarrierIDArray = flightData["CarrierIds"] as? [Int],
                carrierID = carrier["CarrierId"] as? [Int]
                else {fatalError("no carrier IDs available")}
            
            if carrierID[0] == flightCarrierIDArray[0] {
                flightCarrierName = carrier["Name"] as! String
                flightCarrierID = carrierID[0]
            }
        }
    }
    
    
    class func matchFlightLocationInformation() {
        for flightLocation in SkyScannerAPIClient.locationInformation {
            
            guard let
                flightData = SkyScannerAPIClient.lowestPrices[0] as? [String: AnyObject],
                flightOriginID = flightData["OriginId"] as? Int,
                flightDestinationID = flightData["DestinationId"] as? Int,
                airportName = flightLocation["Name"] as? String,
                airportIATACode = flightLocation["IataCode"] as? String
                else { fatalError("no airport name/IATA code available") }
            
            if flightLocation["PlaceId"] as? Int == flightOriginID {
                flightOriginName = airportName
                flightOriginIATACode = airportIATACode
            }
            else if flightLocation["PlaceId"] as? Int == flightDestinationID {
                flightDestinationName = airportName
                flightDestinationIATACode = airportIATACode
            }
        }
    }
    

    class func matchedLocationFlightInfo(location: Location) {
        //call functions to match up carrier ids and flight information
        matchCarrierInformation()
        matchFlightLocationInformation()
        
        guard let
            flightData = SkyScannerAPIClient.lowestPrices[0] as? [String: AnyObject]
            else { fatalError("lowest airfare not available") }
        
        let lowestAirfare = flightData["MinPrice"] as! Int
        
        location.cheapestFlight = Flight(carrierName: flightCarrierName, carrierID: String(flightCarrierID), originIATACode: flightOriginIATACode, destinationIATACode: flightDestinationIATACode, lowestPrice: lowestAirfare)
    }
}



