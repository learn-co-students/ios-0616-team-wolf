//
//  ViewController.swift
//  WanderSpark
//
//  Created by Zain Nadeem on 8/5/16.
//  Copyright © 2016 Zain Nadeem. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let store = LocationsDataStore.sharedInstance

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        store.getLocationsWithCompletion {
//            print("INSIDE COMPLETION BLOCK")
//            print(self.store.locations)
//            
//            let matcher = LocationMatchmaker(matchParameters: ["Outdoors", "City", "Luxury", "Beach", "Nightlife", "Modern", "Food"])
//            matcher.tallyLocationMatches()
//            matcher.sortLocationsByMatchCount()
//            matcher.returnMatchedLocations()
//            
//            print("THESE ARE THE MATCHES:\n")
//            for location in matcher.matchedLocations {
//                print("Compatibility Score: \(location.matchCount)")
//                print("Location Name: \(location.name)")
//                print("###############################")
//            }
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

