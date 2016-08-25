//
//  Settings.swift
//  
//
//  Created by Zain Nadeem on 8/22/16.
//
//

import Foundation


    let onboardingKey = "onboardingShown"
    
    func groupDefaults() -> NSUserDefaults {
        // initialize with suite name for extensions compatibility
        return NSUserDefaults(suiteName: "com.wanderspark.onboarding")!
    }
    
    func registerDefaults(){
        let defaults = groupDefaults()
        defaults.registerDefaults( [ onboardingKey : false ])
    }
