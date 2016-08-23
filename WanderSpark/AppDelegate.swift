//
//  AppDelegate.swift
//  WanderSpark
//
//  Created by Zain Nadeem on 8/5/16.
//  Copyright © 2016 Zain Nadeem. All rights reserved.
//

import UIKit
import CoreLocation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, CLLocationManagerDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        let sharedLocation = UserLocation.sharedInstance
        print(sharedLocation.location?.coordinate)
//        sharedLocation.configureLocationManager()
//        sharedLocation.requestUserLocation()
//        print(sharedLocation.locationManager.location?.coordinate)
        
        return true
    }

}

