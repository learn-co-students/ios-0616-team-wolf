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
    static let flightOrigin = flightData["OriginId"] as? Int
    static let flightDestination = flightData["DestinationId"] as? Int //may not need this but adding it just in case 
    
    let carrierInformation = SkyScannerAPIClient.carrierInformation
    let locationInformation = SkyScannerAPIClient.locationInformation
    
    class func matchCarrierInformation(/*take in carrierInformation array? */) -> String {
        
    }
    
}