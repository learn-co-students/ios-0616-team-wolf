//
//  Location.swift
//  PlayingWithNYTimesAPI
//
//  Created by Flatiron School on 8/4/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import Foundation
import UIKit

class Location {
    var name: String
    var images: [String]
    var description: String
    
    init(name: String, description: String, images: [String]) {
        self.name = name
        self.description = description
        self.images = images
    }
}