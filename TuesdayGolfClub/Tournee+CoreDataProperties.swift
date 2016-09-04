//
//  Tournee+CoreDataProperties.swift
//  TuesdayGolfClub
//
//  Created by Keith Bamford on 02/09/2016.
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
    @NSManaged var scores: [Int]?

}
