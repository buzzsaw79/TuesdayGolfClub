//
//  Tournee+CoreDataProperties.swift
//  TuesdayGolfClub
//
//  Created by Keith Bamford on 06/02/2017.
//  Copyright © 2017 AKA Consultants. All rights reserved.
//

import Foundation
import CoreData


extension Tournee {

    @nonobjc public class func tourneeFetchRequest() -> NSFetchRequest<Tournee> {
        return NSFetchRequest<Tournee>(entityName: "Tournee");
    }

    @NSManaged public var completed: NSNumber?
    @NSManaged public var course: String?
    @NSManaged public var day: String?
    @NSManaged public var par3Winners: [Golfer]?
    @NSManaged public var prizeFund: NSDecimalNumber?
    @NSManaged public var scores: [String:Int]
    @NSManaged public var hasEntrants: NSSet

}

// MARK: Generated accessors for hasEntrants
extension Tournee {

    @objc(addHasEntrantsObject:)
    @NSManaged public func addToHasEntrants(_ value: Golfer)

    @objc(removeHasEntrantsObject:)
    @NSManaged public func removeFromHasEntrants(_ value: Golfer)

    @objc(addHasEntrants:)
    @NSManaged public func addToHasEntrants(_ values: NSSet)

    @objc(removeHasEntrants:)
    @NSManaged public func removeFromHasEntrants(_ values: NSSet)

}
