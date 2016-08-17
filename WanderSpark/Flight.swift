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
    let carrierID : Int
    let originIATACode : String
    let destinationIATACode : String
    let lowestPrice : String
    
    init(carrierName: String, carrierID: Int, originIATACode: String, destinationIATACode: String, lowestPrice: String) {
        self.carrierName = carrierName
        self.carrierID = carrierID
        self.originIATACode = originIATACode
        self.destinationIATACode = destinationIATACode
        self.lowestPrice = lowestPrice
    }
    
    convenience init() {
        self.init(carrierName: "", carrierID: 0, originIATACode: "", destinationIATACode: "", lowestPrice: "")
    }
}
