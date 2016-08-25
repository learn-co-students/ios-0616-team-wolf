//
//  FavoriteLocation.swift
//  
//
//  Created by Flatiron School on 8/20/16.
//
//

import Foundation
import CoreData


class FavoriteLocation: NSManagedObject {

// Insert code here to add functionality to your managed object subclass
    
    func toggleFavoriteStatus() {
        if self.favorite?.intValue == 0 {
            self.favorite = NSNumber(int: 1)
        } else {
            self.favorite = NSNumber(int: 0)
        }
    }

}
