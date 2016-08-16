//
//  Flight.swift
//  WanderSpark
//
//  Created by Betty Fung on 8/12/16.
//  Copyright © 2016 Zain Nadeem. All rights reserved.
//

import Foundation

class Flight {
    
    //all flights obtained from skyscanner are round trip 
    
    let carrierName : String
    let carrierID : String
    let originIATACode : String
    let destinationIATACode : String
    // let departureDate : NSDate
    let lowestPrice : Int //may need to change into String
    
    init(carrierName: String, carrierID: String, originIATACode: String, destinationIATACode: String, lowestPrice: Int) {
        self.carrierName = carrierName
        self.carrierID = carrierID
        self.originIATACode = originIATACode
        self.destinationIATACode = destinationIATACode
        self.lowestPrice = lowestPrice
    }
}
