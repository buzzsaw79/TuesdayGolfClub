//
//  Tournee+CoreDataProperties.swift
//  TuesdayGolfClub
//
//  Created by Keith Bamford on 30/11/2016.
//  Copyright © 2016 AKA Consultants. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Tournee {

    @NSManaged var course: String?
    @NSManaged var date: NSDate?
    @NSManaged var day: String?
    @NSManaged var entryFee: NSDecimalNumber?
    @NSManaged var par3Winners: NSObject?
    @NSManaged var prizeFund: NSDecimalNumber?
    @NSManaged var scores: [Golfer:Int]?
    @NSManaged var completed: NSNumber?
    @NSManaged var hasEntrants: NSSet?

}
