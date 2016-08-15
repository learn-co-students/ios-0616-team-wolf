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
    // let origin : String
    // let destination : String ... these may also be airport names 
    // let departureDate : NSDate
    let lowestPrice : Int //may need to change into String
    
    init(carrierName: String, carrierID: String, lowestPrice: Int) {
        self.carrierName = carrierName
        self.carrierID = carrierID
        self.lowestPrice = lowestPrice
    }
}
