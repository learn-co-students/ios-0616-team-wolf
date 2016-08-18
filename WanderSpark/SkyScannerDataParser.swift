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
    
    static var cheapestFlight = [String : AnyObject]()
    
    static var flightCarrierID = 0
    static var flightCarrierName : String = ""
    static var flightOriginIATACode : String = ""
    static var flightOriginName : String = ""
    static var flightDestinationIATACode : String = ""
    static var flightDestinationName : String = ""
    static var lowestAirfare : Int = 0
    
    static var flightCarrierIDArrayTest = [String]()
    
    class func getMinimumPrice(quotes: [[String: AnyObject]]) -> Int {
        var minimumPrice = 0
        
        let lowestFlightPrices = quotes.sort{
            (($0)["MinPrice"] as? Int) < (($1)["MinPrice"] as? Int)
        }
        
        if let lowestAirfare = lowestFlightPrices.first {
            cheapestFlight = lowestAirfare
        }
        
        
        if let unwrappedMinimumPrice = cheapestFlight["MinPrice"] as? Int {
            minimumPrice = unwrappedMinimumPrice
        } else {
            print("ERROR WITH CHEAPEST FLIGHT")
        }
        print("MINIMUM PRICE: \(minimumPrice)")
        return minimumPrice
    }
    
    
    class func getCarrierInfo(quotes: [[String:AnyObject]], carriers: [[String:AnyObject]]) -> (Int, String) {
        var outboundCarrierID = 0
        var outboundCarrierName = ""
        
        print("CHEAPEST FLIGHT: \(cheapestFlight)")
        
        if let outboundFlight = cheapestFlight["OutboundLeg"] as? [String:AnyObject] {
            
            print("OUTBOUND FLIGHT: \(outboundFlight)")
            
            guard let
                outboundCarriers = outboundFlight["CarrierIds"] as? [Int]
                else {fatalError("ERROR: no carrierID for best flight")}
            
            if let firstCarrierID = outboundCarriers.first {
                outboundCarrierID = firstCarrierID
            }
        
            for carrier in carriers {
                
                guard let carrierID = carrier["CarrierId"] as? Int
                    else {fatalError("no carrier IDs available")}
                
                if outboundCarrierID == carrierID {
                    print("CARRIER MATCH YAYAY <3")
                    outboundCarrierName = carrier["Name"] as! String
                } else {
                    print("NO MATCHES FOUND :(")
                }
            }
        } else {
            print("ERROR WITH CARRIER ID")
        }
        return (outboundCarrierID, outboundCarrierName)
    }


    class func getAirportInfo(quotes: [[String:AnyObject]], airports: [[String : AnyObject]]) -> (String, String){
        
        if let outboundFlight = cheapestFlight["OutboundLeg"] as? [String:AnyObject] {
            
            guard let
                flightOriginID = outboundFlight["OriginId"] as? Int,
                flightDestinationID = outboundFlight["DestinationId"] as? Int
                else { fatalError("no airport name/IATA code available") }
            
            for airport in airports {
                
                guard let
                    airportName = airport["Name"] as? String,
                    airportIATACode = airport["IataCode"] as? String
                    else { fatalError("no airport name/IATA code available") }
                
                if airport["PlaceId"] as? Int == flightOriginID {
                    flightOriginName = airportName
                    flightOriginIATACode = airportIATACode
                }
                else if airport["PlaceId"] as? Int == flightDestinationID {
                    flightDestinationName = airportName
                    flightDestinationIATACode = airportIATACode
                }
            }
        }
        return (flightOriginIATACode, flightOriginName)
    }
    
    
    
    class func matchedLocationFlightInfo(location: Location, quotes: [[String : AnyObject]], carriers: [[String : AnyObject]], airports: [[String : AnyObject]]) -> Flight {
        //call functions to match up carrier ids and flight information
        //            matchCarrierInformation()
        //            matchFlightLocationInformation()
        
        let minimumPrice = String(getMinimumPrice(quotes))
        let carrierInfo = getCarrierInfo(quotes, carriers: carriers)
        let airportInfo = getAirportInfo(quotes, airports: airports)
        
        let cheapestFlight = Flight(carrierName: carrierInfo.1, carrierID: carrierInfo.0, originIATACode: airportInfo.0, destinationIATACode: airportInfo.1, lowestPrice: minimumPrice)
        location.cheapestFlight = cheapestFlight
        return cheapestFlight
    }
}
        
        
        
        
        /*
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
        return flightCarrierName */



