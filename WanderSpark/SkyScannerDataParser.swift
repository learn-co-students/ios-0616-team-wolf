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
    
    static let flight = SkyScannerAPIClient.bestFlight
    
    static var flightCarrierID = 0
    static var flightCarrierName : String = ""
    static var flightOriginIATACode : String = ""
    static var flightOriginName : String = ""
    static var flightDestinationIATACode : String = ""
    static var flightDestinationName : String = ""
    static var lowestAirfare : Int = 0
    
    static var flightCarrierIDArrayTest = [String]()
    

    class func matchCarrierInformation() {
        
        print("match carrier function called")
        print("flightInfo: \(flight)")
        guard let selectedFlightCarrierID = flight["CarrierIds"] as? [Int] else {fatalError("ERROR: no carrierID for best flight")}
        flightCarrierID = selectedFlightCarrierID[0]
        print("flightInfoCarrierID: \(String(selectedFlightCarrierID))")
        
        for carrier in SkyScannerAPIClient.carrierInformation {
            //looping through carriers array in response
            print("current carrier: \(carrier)")
            
            if let flightCarrierIDArray = flight["CarrierIds"] as? [Int] {
                //flight carrier id in cheapest flight price quote
                print("1: YAY flight carrierID array passed")
                
                guard let carrierID = carrier["CarrierId"] as? Int
                    else {fatalError("no carrier IDs available")}
                //this is in the carriers array
                print("2: YAY carrierID for loop passed")
                
                let selectedFlightCarrierID = flightCarrierIDArray[0]
                
                print("***** LOOPING THROUGH CARRIERS *****")
                print("Current Carrier in loop: \(carrier)\nCarrierID: \(carrierID)")
                print("Flight Carrier ID for selected flight: \(selectedFlightCarrierID)")
                print("***** FIN *****")
                
                if selectedFlightCarrierID == carrierID {
                    print("CARRIER MATCH YAYAY <3")
                    flightCarrierName = carrier["Name"] as! String
                    flightCarrierID = carrierID
                } else {
                    print("NO MATCHES FOUND :(")
                }
            } else {
                print("could not go through flight carrier IDs from bestFlight")
            }
        }
    }
    
        
        class func matchFlightLocationInformation() {
            for flightLocation in SkyScannerAPIClient.locationInformation {
                
                guard let
                    flightOriginID = flight["OriginId"] as? Int,
                    flightDestinationID = flight["DestinationId"] as? Int,
                    airportName = flightLocation["Name"] as? String,
                    airportIATACode = flightLocation["IataCode"] as? String
                    else { fatalError("no airport name/IATA code available") }
                
                if flightLocation["PlaceId"] as? Int == flightOriginID {
                    flightOriginName = airportName
                    flightOriginIATACode = airportIATACode
                }
                else if flightLocation["PlaceId"] as? Int == flightDestinationID {
                    flightDestinationName = airportName
                    flightDestinationIATACode = airportIATACode
                }
            }
        }
        
        
        class func matchedLocationFlightInfo(location: Location) -> Flight {
            //call functions to match up carrier ids and flight information
            matchCarrierInformation()
            matchFlightLocationInformation()
            
            let cheapestFlight = Flight(carrierName: flightCarrierName, carrierID: flightCarrierID, originIATACode: flightOriginIATACode, destinationIATACode: flightDestinationIATACode, lowestPrice: SkyScannerAPIClient.lowestAirfare)
            location.cheapestFlight = cheapestFlight
            return cheapestFlight
        }
}



