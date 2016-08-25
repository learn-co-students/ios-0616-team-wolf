//
//  Settings.swift
//  
//
//  Created by Zain Nadeem on 8/22/16.
//
//

import Foundation




class Settings {
    
    
    let onboardingKey = "onboardingShown"
    
    class func groupDefaults() -> NSUserDefaults {
        // initialize with suite name for extensions compatibility
        return NSUserDefaults(suiteName: "com.wanderspark.onboarding")!
    }
    
    class func registerDefaults(){
        let defaults = groupDefaults()
        defaults.registerDefaults( [ onboardingKey : false ])
    }
}