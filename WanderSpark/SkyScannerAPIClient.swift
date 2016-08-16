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

class SkyScannerAPIClient {
    
    let store = LocationsDataStore.sharedInstance
    static var lowestPrices = [[String:AnyObject]]()
    static var carrierInformation = [[String:AnyObject]]()
    static var locationInformation = [[String:AnyObject]]()
    
    
    class func getFlights(location: Location, completion: ()-> ()) {
        
        Alamofire.request(.GET, "http://partners.api.skyscanner.net/apiservices/browsequotes/v1.0/US/USD/en-US/40.730610,-73.935242-latlong/\(location.coordinates.0),\(location.coordinates.1)-latlong/anytime/anytime?apikey=\(Secrets.skyscannerAPIKey)").responseJSON { (response) in
            
            if let flightsResponse = response.result.value as? NSDictionary {
                
                guard let
                flightQuotes = flightsResponse["Quotes"] as? [[String:AnyObject]],
                    //only care about key value pairs whose values are Int
                //getting place information 
                locationInfo = flightsResponse["Places"] as? [[String:AnyObject]],
                //getting carrier information 
                carrierList = flightsResponse["Carriers"] as? [[String:AnyObject]]
                else {
                        fatalError("ERROR: No flights found for location")
                }
                
                //sorting and assigning response to variables/properties
                lowestPrices = flightQuotes.sort{
                    (($0)["MinPrice"] as? Int) < (($1)["MinPrice"] as? Int)
                }
                locationInformation = locationInfo
                carrierInformation = carrierList
                
                print("***************** FLIGHT INFORMATION *****************")
                print("\n\nNAME: \(location.name)")
                print("LOWEST PRICES: \(lowestPrices)")
                print("LOCATION: \(locationInformation)")
                print("CARRIERS: \(carrierInformation)\n\n")
                print("******************* END FLIGHT INFO *******************")
                
                
            }
            
                
//                var selectedFlight = flightQuotes[0]
//                var lowestPrice = flightQuotes[0]["MinPrice"]
//                
//                for quote in flightQuotes {
//                    guard let flightMinPrice = quote["MinPrice"]
//                        else {
//                        fatalError("ERROR: no flight quotes found")
//                        }
//                    if flightMinPrice < lowestPrice {
//                        lowestPrice = flightMinPrice
//                        selectedFlight = quote
//                    }
//                }
//                        flightOriginAirportID = quote["OriginId"] as? Int,
//                        flightDepartureDate = quote["DepartureDate"] as? String,
                        // flightOutboundInfo = quote["OutboundLeg"] as? [String:AnyObject],
                        //flightOutboundCarrierID = flightOutboundInfo["CarrierIds"] as? [Int]                         else {
                
               // let flightQuoteOfInterest = lowestFlightQuote
                
//                for flightLocation in locationInfo {
//                    guard let
//                    locationPlaceId = flightLocation["PlaceId"] as? String, //or Int
//                    locationIATACode = flightLocation["IataCode"] as? String, //or Int
//                    locationCityName = flightLocation["Cityname"] as? String
//                        else {
//                            fatalError("ERROR: no places for flight quotes found")
//                    }
//                }
//                
//                for carrierInfo in carrierList {
//                    guard let
//                    carrierID = carrierInfo["CarrierID"] as? [String:String],
//                    carrierName = carrierInfo["Name"] as? String
//                        else {
//                            fatalError("ERROR: no carrier info for flights found")
//                    }
//                }
                
            }
            
        }
        
    }
    
    //    static func getPricesForDestination(location: Location, completion:() -> ())
    //    {
    //        var sortedArrayOfPrices: [Int] = []
    //
    //        print("FLIGHTS: Location coordinates: \(location.coordinates)")
    //
    //        let stringURL = "https://api.skyscanner.net/apiservices/browsequotes/v1.0/US/USD/en-US/40.730610,-73.935242-latlong/\(location.coordinates.0),\(location.coordinates.1)-latlong/anytime/anytime?apikey=\(Secrets.skyscannerAPIKey)"
    //
    //        //create the string URL
    //
    //        let nsURL = NSURL(string: stringURL)
    //        //create the NSURL version of the URL
    //
    //        let session = NSURLSession.sharedSession()
    //        //creating the session
    //
    //        guard let unwrappedURL = nsURL else { fatalError("Invalid URL") }
    //        //unwrapping the URL
    //
    //        //creating the task to get the data, response, and error
    //        //only interested in the data
    //        let task = session.dataTaskWithURL(unwrappedURL, completionHandler: { (data,
    //            response, error) -> Void in
    //
    //            if data == nil
    //            {
    //                print("NO INFORMATION AVAILABLE")
    //            }
    //            else {
    //
    //                do{
    //                    var ArrayOfPrices: [Int] = []
    //
    //                    let dataDictionary = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments) as? NSDictionary
    //
    //                    guard let allTheDictionaries = dataDictionary else { fatalError("INVALID") }
    //
    //                    guard let priceArray = allTheDictionaries["Quotes"] as? NSArray else { fatalError("INVALID") }
    //
    //                    for singleDictionary in priceArray
    //                    {
    //                        let priceOfFlight = singleDictionary["MinPrice"] as? Int
    //
    //                        guard let unwrappedPrice = priceOfFlight else {fatalError("INVALID") }
    //
    //                        ArrayOfPrices.append(unwrappedPrice)
    //
    //                        sortedArrayOfPrices = ArrayOfPrices.sort(<)
    //
    //                    }
    //
    //                    guard let cheapestPrice = sortedArrayOfPrices.first else {fatalError()}
    //
    //                    completion()
    //                    //let firstDictionaryInQuotesArray = priceArray[0] as? NSDictionary
    //                    //guard let nextDictionary = firstDictionaryInQuotesArray else { fatalError("INVALID") }
    //                    //let actualPriceOfFlight = nextDictionary["MinPrice"] as? Int
    //                    //guard let priceOfFlight = actualPriceOfFlight else { fatalError("INVALID") }
    //                    //print(priceOfFlight)
    //                    //starts of as a dictionary - Done
    //                    //Then cast as an array in "Quotes" - Done
    //                    //Then cast as a dictionary and get the value for the "minPrice" key
    //
    //                }
    //
    //                catch {
    //                    print("ERROR OCCURRED HERE!")
    //                }
    //            }
    //        })
    //        task.resume()
    //
    //    }



// ####################################################
//print("api getting called")
//    let urlString = "http://partners.api.skyscanner.net/apiservices/browsequotes/v1.0/US/USD/en-US/40.7128,-74.0059-latlong/-33.8688,151.2093-latlong/anytime/anytime?apiKey=\(Secrets.api_keySkyScanner)"
//
//    Alamofire.request(.GET, urlString)
//        .validate()
//        .responseJSON { response in
//
//            print("made it here")
//            print(response)
//    }
//        let url = "http://partners.api.skyscanner.net/apiservices/browsequotes/v1.0/US/USD/en-US/40.7128,-74.0059-latlong/-33.8688,151.2093-latlong/anytime/anytime?apiKey=\(Secrets.api_keySkyScanner)")
//
//        let session = NSURLSession.sharedSession()
//
//        let request = NSMutableURLRequest(URL: url!)
//
//        var task = session.dataTaskWithRequest(request) { (data, response, error) in
//            print(response)
//
//            print("made it to here")
//        }

//task.resume()
//        print("SkyScanner response received: \(response)")
//
//        guard let responseDictionary = response.result.value as? NSDictionary else
//        {print("Error occurred here"); return}
//
////        completion(responseDictionary)
// //           print(responseDictionary)
//
//        guard let quotesArray = responseDictionary["Quotes"] as? [String] else {
//            print("Error occurred here"); return}
//
//            print(quotesArray)
//
//        for setOfDictionary in quotesArray
//        {
//            guard let singleDictionary = setOfDictionary as? [String: AnyObject] else {print("Error occurred here"); return}
//
//            guard let priceOfTrip = singleDictionary["MinPrice"] as? String else {print("Error occurred here"); return }
//
//            print(priceOfTrip)
//
//        }

//print("Finished calling SkyScanner")