//
//  Golfer+CoreDataProperties.swift
//  TuesdayGolfClub
//
//  Created by Keith Bamford on 08/09/2016.
//  Copyright © 2016 AKA Consultants. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Golfer {

    @NSManaged var clubHandicap: NSDecimalNumber?
    @NSManaged var firstName: String?
    @NSManaged var name: String?
    @NSManaged var playingHandicap: NSNumber?
    @NSManaged var scores: NSObject?
    @NSManaged var surname: String?
    @NSManaged var tuesdayHandicap: NSNumber?
    @NSManaged var membershipNumber: String?
    @NSManaged var playsInA: Tournee?

}
