//
//  LocationMatchmaker.swift
//  WanderSpark
//
//  Created by Flatiron School on 8/8/16.
//  Copyright © 2016 Zain Nadeem. All rights reserved.
//

import Foundation

class LocationMatchmaker {
    
    var positiveMatchParameters = [String]()
    var negativeMatchParameters = [String]()
    
    let store = LocationsDataStore.sharedInstance
    
    let matchingDictionary = ["City": ["city", "metropoli", "crowd", "busy", "bustl", "touris", "capital", "cosmopolitan", "urban", "skyscraper", "downtown"],
                              "Country" : ["country", "scenic", "lake", "grass", "natur", "rural", "idyll", "pastor", "quiet", "laid-back", "charm", "town", "humdrum", "provinc"],
                              "Mountains" : ["climb", "peak", "ski", "snowboard", "Alps", "Andes", "Appalachia", "Himalaya", "cable car", "sherpa"],
                              "Beaches" : ["beach", "sand", "sea", "surf", "ocean", "wave", "sun", "maritime", "coast", "resort", "island", "cruise"],
                              "Shopping" : ["shop", "market", "bazaar", "brand", "trend", "boutique", "design", "styl", "antique", "store", "fashion", "cloth", "jewelry", "artisan", "craft"],
                              "Outdoors" : ["outdoor", "park", "green", "natur", "tropic", "forest", "volcan", "lake", "river", "valley", "snow", "sun", "landscape", "panoram", "view", "rugged", "camp", "ranch", "verdant", "eco", "farm", "vineyard", "gondola", "picnic", "trail"],
                              "Sightseeing" : ["museum", "art", "architectur", "galler", "plaza", "histor", "temple", "pagoda", "cathedral", "sculptur", "opera", "landmark", "monument", "college", "universit", "campus", "stroll"],
                              "Nightlife" : ["night", "music", "party", "hedonist", "danc", "casino", "lounge", "club", "theater", "bar"],
                              "Historic" : ["histor", "old", "past", "plaza", "piazza", "square", "cemetery", "classic", "royal", "anniversary", "ruin", "ancient", "medieval", "castle"],
                              "Modern" : ["modern", "new", "fresh", "young", "international", "cosmopolitan", "trend", "hip",  "prosper", "innovat", "renovat", "boom", "tech", "entrepreneur", "transform"],
                              "Food" : ["food", "culinary", "cuisine", "eat", "restaurant", "dining", "dine", "dinner", "meal", "dish", "snack", "drink", "bar", "wine", "cocktail", "pub", "brewer", "beer", "pint", "chef", "flavor", "meat",  "bistro", "farm", "vineyard", "coffee", "Michelin"],
                              "Fitness" : ["fitness", "run", "walk", "stroll", "backpack", "bik", "kayak",  "hik", "trek", "ski", "sport", "yoga", "meditat", "vegetarian", "green", "eco", "locavore", "Olympic"],
                              "Luxury" : ["fancy", "high-end",  "upscale", "expens", "cachet", "sophisticat", "aristocrat", "luxur", "chic", "posh", "styl", "pamper", "hotel", "spa"],
                              "Adventure" : ["ventur", "grit", "shabby", "industr", "funky", "bohemian", "creativ", "divers", "cultur", "remote", "off-beat", "budget", "festival", "lively", "energ", "dynam", "vibrant", "secret"]]
    
    
    init(positiveMatchParameters: [String], negativeMatchParameters: [String]) {
        self.positiveMatchParameters = positiveMatchParameters
        self.negativeMatchParameters = negativeMatchParameters
    }
    
    
    func tallyPositiveLocationMatches() {
        
        for location in store.locations {
            
            for parameter in positiveMatchParameters {
                
                guard let matchWords = matchingDictionary[parameter] else { print("Error: Invalid location matching parameter is not a key in the Matching Dictionary."); return }
                
                for word in matchWords {
                    if location.description.containsString(word) {
                        location.matchCount += 1
                    }
                }
            }
        }
    }
    
    
    func tallyNegativeLocationMatches() {
        
        for location in store.locations {
            
            for parameter in negativeMatchParameters {
                
                guard let matchWords = matchingDictionary[parameter] else { print("Error: Invalid location matching parameter is not a key in the Matching Dictionary."); return }
                
                for word in matchWords {
                    if location.description.containsString(word) {
                        location.matchCount -= 1
                    }
                }
            }
        }
    }

    
    func sortLocationsByMatchCount() {
        
        store.locations.sortInPlace({ $0.matchCount > $1.matchCount })
    }
    
    
    func returnMatchedLocations() {
        var matchedLocationsCount = 0
        
        while store.matchedLocations.count < 10 {
            let match = store.locations[matchedLocationsCount]
            store.matchedLocations.append(match)
            matchedLocationsCount += 1
        }
    }

}