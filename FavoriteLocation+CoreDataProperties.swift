//
//  FavoriteLocation+CoreDataProperties.swift
//  
//
//  Created by Flatiron School on 8/20/16.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension FavoriteLocation {

    @NSManaged var name: String?
    @NSManaged var snippet: String?
    @NSManaged var matchCount: NSNumber?
    @NSManaged var image: String?

}
