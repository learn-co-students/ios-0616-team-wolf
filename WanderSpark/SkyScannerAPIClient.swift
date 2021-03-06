//
//  SkyScannerAPIClient.swift
//  WanderSpark
//
//  Created by Flatiron School on 8/9/16.
//  Copyright © 2016 Zain Nadeem. All rights reserved.
//

import Alamofire
import Foundation
import SwiftyJSON
import CoreLocation

class SkyScannerAPIClient {
    
    static var lowestFlightPrices = [[String:AnyObject]]()
    static var carrierInformation = [[String:AnyObject]]()
    static var locationInformation = [[String:AnyObject]]()
    static var bestFlight = [String:AnyObject]()
    static var lowestAirfare = ""
    
    enum SkyscannerAPIError: ErrorType {
        case InvalidJSONDictionaryCast
        case InvalidDictionaryResponseKey
        case InvalidDictionaryDocsKey
    }
    
    typealias FlightCompletion = (Flight, ErrorType?) -> ()
    
    static let store = LocationsDataStore.sharedInstance
    static let sharedUserLocation = UserLocation.sharedInstance
    
    class func getFlights(location: Location, completion: FlightCompletion) {
        
        if location.name == "Williamsburg (Va)" {
            location.coordinates = (37.531399, -77.476009) //coordinates for servicing airport in richmond, va
        } else if location.name == "Mendocino (Calif)" {
            location.coordinates = (38.575764, -121.478851) //coordinates for servicing airport in sacramento, ca
        }
        
        // in the future, if coordinates cannot be found or no flights are available for a location, use google maps to geolocate coordinates of nearest airport
        
        var userLatitude = Double()
        var userLngitude = Double()
        
        guard let coordinates = location.coordinates else { print("ERROR: failed to unwrap coordinate values for \(location.name)"); return }
        
        print("user coordinates from sky scanner api client: \(sharedUserLocation.userCoordinates)")
        print("zip coordinates from sky scanner api client: \(sharedUserLocation.userZipCodeCoordinates)")
        //obtain user coordinates
        if sharedUserLocation.userCoordinates != nil {
            //enabled core location
            print("using coordinates from core location")
            if let userLocationCoordinates = sharedUserLocation.userCoordinates {
                userLatitude = userLocationCoordinates.latitude
                userLngitude = userLocationCoordinates.longitude
            } else {
                print("could not get user coordinates using core location")
            }
        } else if sharedUserLocation.userZipCodeCoordinates != nil {
            print("using coordinates from zipcode")
            if let userZipCoordinates = sharedUserLocation.userZipCodeCoordinates{
                print ("zipcode coordinates: \(userZipCoordinates)")
                userLatitude = userZipCoordinates.0
                userLngitude = userZipCoordinates.1
            }
        }
        
        
        //not allowing for the coordinates that are coming in from userLocation class
        
        print("UNWRAPPED USER COORDINATES: (\(userLatitude), \(userLngitude))")
        
        Alamofire.request(.GET, "http://partners.api.skyscanner.net/apiservices/browsequotes/v1.0/US/USD/en-US/\(userLatitude),\(userLngitude)-latlong/\(coordinates.0),\(coordinates.1)-latlong/anytime/anytime?apikey=\(Secrets.skyscannerAPIKey)").responseJSON { (response) in
            
            var flightQuotes = [[String:AnyObject]]()
            var locationInfo = [[String:AnyObject]]()
            var carrierList = [[String:AnyObject]]()
            
            switch response.result {
            case .Failure(let error):
                completion(Flight(), error)
                
            case .Success(let value):
                guard let flightsResponse = value as? NSDictionary else { completion(Flight(), SkyscannerAPIError.InvalidJSONDictionaryCast); return }
                guard let
                    flightQuotesArray = flightsResponse["Quotes"] as? [[String:AnyObject]],
                    locationInfoArray = flightsResponse["Places"] as? [[String:AnyObject]],
                    carrierListArray = flightsResponse["Carriers"] as? [[String:AnyObject]]
                    else {
                        print("ERROR: No flights found for \(location.name)"); return
                }
                
                flightQuotes = flightQuotesArray
                locationInfo = locationInfoArray
                carrierList = carrierListArray
            }
            
            completion(SkyScannerDataParser.matchedLocationFlightInfo(location, quotes: flightQuotes, carriers: carrierList, airports: locationInfo), nil)
        } //end of Alamofire request
    }//end of class func
}