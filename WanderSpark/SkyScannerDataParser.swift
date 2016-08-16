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
    
    static let flightData = SkyScannerAPIClient.lowestPrices[0]
    static let flightCarrierID = flightData["CarrierIds"] as? [Int]
    static let flightOriginID = flightData["OriginId"] as? Int
    static let flightDestinationID = flightData["DestinationId"] as? Int //may not need this but adding it just in case
    
    static let flightCarrierName : String
    static let flightOriginIATACode : String
    static let flightOriginName : String
    static let flightDestinationName : String
    
    
    class func matchCarrierInformation() -> String {
        for carrier in SkyScannerAPIClient.carrierInformation {
            if carrier["CarrierId"] as? Int == flightCarrierID {
                flightCarrierName = carrier["Name"] as? String
            }
        }
        return flightCarrierName
    }
    
    
    class func matchLocationInformation() -> String /*(name: String, IATACode: String) */{
        for originID in SkyScannerAPIClient.locationInformation {
            
        }
        
        return ""
    }
    
    
    
}