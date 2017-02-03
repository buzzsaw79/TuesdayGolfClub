//
//  Tournee+CoreDataProperties.swift
//  TuesdayGolfClub
//
//  Created by Keith Bamford on 02/02/2017.
//  Copyright © 2017 AKA Consultants. All rights reserved.
//

import Foundation
import CoreData


extension Tournee {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Tournee> {
        return NSFetchRequest<Tournee>(entityName: "Tournee");
    }

    @NSManaged public var completed: NSNumber?
    @NSManaged public var course: String?
    @NSManaged public var date: NSDate?
    @NSManaged public var day: String?
    @NSManaged public var entryFee: NSDecimalNumber?
    @NSManaged public var par3Winners: NSObject?
    @NSManaged public var prizeFund: NSDecimalNumber?
    @NSManaged public var scores: NSObject?
    @NSManaged public var hasEntrants: NSSet?
    @NSManaged public var golferScores: NSSet?

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



    @objc(addGolferScoresObject:)
    @NSManaged public func addToGolferScores(_ value: Golfer)

    @objc(removeGolferScoresObject:)
    @NSManaged public func removeFromGolferScores(_ value: Golfer)

    @objc(addGolferScores:)
    @NSManaged public func addToGolferScores(_ values: NSSet)

    @objc(removeGolferScores:)
    @NSManaged public func removeFromGolferScores(_ values: NSSet)

}
