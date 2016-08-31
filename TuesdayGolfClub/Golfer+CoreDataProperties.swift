//
//  Golfer+CoreDataProperties.swift
//  TuesdayGolfClub
//
//  Created by Keith Bamford on 31/08/2016.
//  Copyright © 2016 AKA Consultants. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Golfer {

    @NSManaged var name: String?
    @NSManaged var firstName: String?
    @NSManaged var surname: String?
    @NSManaged var clubHandicap: NSDecimalNumber?
    @NSManaged var tuesdayHandicap: NSNumber?
    @NSManaged var playingHandicap: NSNumber?

}
