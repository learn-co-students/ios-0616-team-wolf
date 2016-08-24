//
//  AppDelegate.swift
//  WanderSpark
//
//  Created by Zain Nadeem on 8/5/16.
//  Copyright © 2016 Zain Nadeem. All rights reserved.
//

import UIKit
import CoreLocation


enum Storyboard: String {
    case Main = "Main"
    case Onboarding = "Onboarding"
}


@UIApplicationMain



class AppDelegate: UIResponder, UIApplicationDelegate, CLLocationManagerDelegate {

    var window: UIWindow?
    var locationManager: CLLocationManager!
    let userLocation = UserOrigin.sharedOrigin
    let stuff = UserOrigin()

    let store = LocationsDataStore.sharedInstance

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
      userLocation.checkCoreLocationPermission()
        
       
        
//        locationManager = CLLocationManager()
//        locationManager.delegate = self
//        locationManager.desiredAccuracy = kCLLocationAccuracyBest
//        if CLLocationManager.authorizationStatus() == .AuthorizedWhenInUse
//        {
//            locationManager.startUpdatingLocation()
//        }
//        else if CLLocationManager.authorizationStatus() == .NotDetermined
//        {
//            locationManager.requestWhenInUseAuthorization()
//        }
//        else if CLLocationManager.authorizationStatus() == .Restricted
//        {
//            print("Error! Please Provide Information")
//        }
//        locationManager.startUpdatingLocation()
//        UserOrigin.checkCoreLocationPermission()
//        UserOrigin.locationManager()
//        stuff.checkCoreLocationPermission()
//      stuff.locationManager(locationManager, didUpdateLocations: )
//        stuff.checkCoreLocationPermission()
//        SkyScannerAPIClient.getPricesForDestination(Location.init(name: "Barcelona", description: "", images: [""], url: "")) { (<#Int#>) in
//            print("It worked")
//        }
        
        
        registerDefaults()
         print("*******")
         print(groupDefaults().boolForKey(onboardingKey))
         print("*******")
        
        if(groupDefaults().boolForKey(onboardingKey)) {
            launchStoryboard(Storyboard.Main)
        } else {
            
            launchStoryboard(Storyboard.Onboarding)
        }
        return true
    }
    
//    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        
//        print("\nlocation manager\n")
//        guard let lastLocation = locations.last else { fatalError("no locations") }
//        userOrigin.location = lastLocation
//        print(lastLocation)
//        
//    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    func launchStoryboard(storyboard: Storyboard) {
        UIApplication.sharedApplication().setStatusBarHidden(true, withAnimation: .Slide)
        let storyboard = UIStoryboard(name: storyboard.rawValue, bundle: nil)
        let controller = storyboard.instantiateInitialViewController()! as UIViewController
        self.window?.rootViewController = controller
    }

}

