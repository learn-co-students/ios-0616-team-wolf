//
//  AppDelegate.swift
//  WanderSpark
//
//  Created by Zain Nadeem on 8/5/16.
//  Copyright © 2016 Zain Nadeem. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    let store = LocationsDataStore.sharedInstance

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        // 0. set up main queue for UI stuff
        let mainOperationQueue = NSOperationQueue.mainQueue()
        
        // 1. load NYTimes location data while user is swiping through survey
            //main thread: swiping 
            //other thread: call NYTimesAPI for every other swipe, use index to determine the call
        let obtainLocations = NSBlockOperation {
            print("locations block called")
            self.store.getLocationsWithCompletion ({ })
        }
        obtainLocations.qualityOfService = .UserInitiated
        mainOperationQueue.addOperation(obtainLocations)
        
        
        //THINGS THAT HAPPEN DURING LOADING/MATCHING SCREEN (main thread)
        // 2. match user to destinations
            //main thread: loading screen of airplane zipping around? or something with the crystal ball!
            //other thread: matching dictionary magic :)
        
        
        
        // 3. obtain coordinates for matched locations
            //main thread: loading screen
            //background thread:
        let obtainLocationCoordinatesQueue = NSOperationQueue()
        obtainLocationCoordinatesQueue.qualityOfService = .Utility
        if store.matchedLocations.count > 0 /* AND matching thread in step 2 is complete */ {
            mainOperationQueue.addOperationWithBlock {
                if obtainLocations.finished {
                    GooglePlacesAPIClient.getLocationCoordinatesWithCompletion({
                    })
                }
            }
        }
        
        // obtainLocationCoordinatesBlockOperation.addDependency(obtainLocationsQueue)
//        obtainLocationCoordinatesBlockOperation.completionBlock = {
//            print("in coordinates completion block")
//            if obtainLocationCoordinatesBlockOperation.finished {
//                print("DONE WITH COORDINATES QUEUE")
//            }
//        }
        
        
//        mainOperationQueue.addOperations([obtainLocationsQueue, obtainLocationCoordinatesBlockOperation], waitUntilFinished: false)
        
        
        
        // 4. use coordinates for matched locations to get flight information
            //main thread: loading screen 
            //other thread: get flight information from skyscannerAPI 
                //may need to check if coordinates are already populated first
        
        
        return true
    }

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


}

