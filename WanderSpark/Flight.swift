//
//  Flight.swift
//  WanderSpark
//
//  Created by Betty Fung on 8/12/16.
//  Copyright © 2016 Zain Nadeem. All rights reserved.
//

import Foundation

class Flight {
    
    let carrierName : String
    let carrierID : String
    let lowestPrice : Int
    
    init(carrierName: String, carrierID: String, lowestPrice: Int) {
        self.carrierName = carrierName
        self.carrierID = carrierID
        self.lowestPrice = lowestPrice
    }
}
