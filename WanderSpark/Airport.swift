//
//  Airport.swift
//  WanderSpark
//
//  Created by Betty Fung on 8/6/16.
//  Copyright © 2016 Zain Nadeem. All rights reserved.
//

import Foundation

class Airport {
    var airportName : String
    var airportCode : String
    
    init(airportName: String, airportCode: String) {
        self.airportName = airportName
        self.airportCode = airportCode
    }
    
    convenience init(airportName: String) {
        self.init(airportName: airportName, airportCode: "EMPTY")
    }
}
