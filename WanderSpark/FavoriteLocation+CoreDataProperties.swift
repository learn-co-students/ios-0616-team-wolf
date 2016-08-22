//
//  FavoriteLocation+CoreDataProperties.swift
//  
//
//  Created by Flatiron School on 8/21/16.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension FavoriteLocation {

    @NSManaged var imageURL: String?
    @NSManaged var matchCount: NSNumber?
    @NSManaged var name: String?
    @NSManaged var snippet: String?
    @NSManaged var articleURL: String?

}
