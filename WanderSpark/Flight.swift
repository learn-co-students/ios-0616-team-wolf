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
    
    static let store = LocationsDataStore.sharedInstance
    
    let carrierName : String?
    let carrierID : Int?
    let originIATACode : String?
    let destinationIATACode : String?
    let lowestPrice : String?
    
    init(carrierName: String?, carrierID: Int?, originIATACode: String?, destinationIATACode: String?, lowestPrice: String?) {
        self.carrierName = carrierName
        self.carrierID = carrierID
        self.originIATACode = originIATACode
        self.destinationIATACode = destinationIATACode
        self.lowestPrice = lowestPrice
    }
    
    convenience init() {
        self.init(carrierName: nil, carrierID: nil, originIATACode: nil, destinationIATACode: nil, lowestPrice: nil)
    }
    
    class func printFlightInformation(location: Location) {
        
        guard let
            coordinates = location.coordinates,
            carrierName = location.cheapestFlight!.carrierName,
            originAirport = location.cheapestFlight!.originIATACode,
            price = location.cheapestFlight!.lowestPrice
            else { fatalError("ERROR: could not unwrap flight information for print statment") }
        
        print("***************** FLIGHT INFORMATION *****************")
        print("\n\nNAME: \(location.name)")
        print("DESCRIPTION: \(location.description)")
        print("COORDINATES: \(coordinates)")
        print("CARRIER: \(carrierName)")
        print("FLIGHT ORIGIN AIRPORT: \(originAirport)")
        print("PRICE: \(price)\n\n")
        print("******************* END FLIGHT INFO *******************")
    }
    
    class func checkLocationFlightInformation(location: Location) {
        
        guard let
            coordinates = location.coordinates,
            carrierName = location.cheapestFlight!.carrierName,
            originAirport = location.cheapestFlight!.originIATACode,
            price = location.cheapestFlight!.lowestPrice
            else { fatalError("ERROR: could not unwrap flight information in check to verify they have been populated correctly") }
        
        if originAirport == "" || price == String(0) || price == "" {
            print("MISSING INFO FOR \(location.name.uppercaseString)")
            CoordinateAndFlightQueues.numberOfFlightsRetrieved -= 1
            CoordinateAndFlightQueues.flightsRetrieved = false
            SkyScannerAPIClient.getFlights(location, completion: { (missingFlightInfo, nil) in
                print("getting missing flight information for \(location.name)")
            })
        }
        
    }
}
