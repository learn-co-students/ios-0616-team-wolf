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
    
    static let flightData = SkyScannerAPIClient.lowestPrices[0]
    static let flightCarrierID = flightData["CarrierIds"] as? [Int]
    static let flightOriginID = flightData["OriginId"] as? Int
    static let flightDestinationID = flightData["DestinationId"] as? Int
    
    static let flightCarrierName : String
    static let flightOriginIATACode : String
    static let flightOriginName : String
    static let flightDestinationIATACode : String
    static let flightDestinationName : String
    
    
    class func matchCarrierInformation() {
        for carrier in SkyScannerAPIClient.carrierInformation {
            if carrier["CarrierId"] as? Int == flightCarrierID {
                flightCarrierName = carrier["Name"] as? String
            }
        }
    }
    
    
    class func matchFlightLocationInformation() {
        for flightLocation in SkyScannerAPIClient.locationInformation {
            if flightLocation["PlaceId"] as? Int == flightOriginID {
                flightOriginName = flightLocation["Name"] as? String
                flightOriginIATACode = flightLocation["IataCode"] as? String
            }
            else if flightLocation["PlaceId"] as? Int == flightDestinationID {
                flightDestinationName = flightLocation["Name"] as? String
                flightDestinationIATACode = flightLocation["IataCode"] as? String
            }
        }
    }
    
    class func matchedLocationFlightInfo() {
        for location in store.matchedLocations {
            
        }
    }
    
    
    
}