//
//  testingClass.swift
//  WanderSpark
//
//  Created by Betty Fung on 8/13/16.
//  Copyright © 2016 Zain Nadeem. All rights reserved.
//

import Foundation



class Testing {
    
    static let store = LocationsDataStore.sharedInstance
    
    class func testingStuff() {
        
        for location in store.matchedLocations {
            print("********** DESTINATION INFORMATION ************")
            print("Name: \(location.name)")
            print("Coordinates: \(location.coordinates)")
            // print("Flight Price: \(location.cheapestFlight.lowestPrice)")
            print("Snippet Description: \(location.description)")
            print("***********************************************")
        }
    }
    
}