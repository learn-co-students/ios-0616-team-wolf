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
    
    static let flightDataWithLowestPrice = SkyScannerAPIClient.lowestPrices[0]
    static let flightCarrierID = flightDataWithLowestPrice["CarrierIds"] as? [Int]
    static let flightOriginID = flightDataWithLowestPrice["OriginId"] as? Int
    static let flightDestinationID = flightDataWithLowestPrice["DestinationId"] as? Int
    
    static var flightCarrierName : String = ""
    static var flightOriginIATACode : String = ""
    static var flightOriginName : String = ""
    static var flightDestinationIATACode : String = ""
    static var flightDestinationName : String = ""
    
    
    
    class func matchCarrierInformation() {
        for carrier in SkyScannerAPIClient.carrierInformation {
            if carrier["CarrierId"]![0] == flightCarrierID {
                flightCarrierName = carrier["Name"] as! String
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
    

    class func matchedLocationFlightInfo(location: Location) {
        //call functions to match up carrier ids and flight information
        matchCarrierInformation()
        matchFlightLocationInformation()
        
        location.cheapestFlight = Flight(carrierName: flightCarrierName, carrierID: flightCarrierID, originIATACode: flightOriginIATACode, destinationIATACode: flightDestinationIATACode, lowestPrice: flightDataWithLowestPrice["MinPrice"])
    }
}



