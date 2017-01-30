//
//  Golfer+CoreDataProperties.swift
//  TuesdayGolfClub
//
//  Created by Keith Bamford on 20/01/2017.
//  Copyright © 2017 AKA Consultants. All rights reserved.
//

import Foundation
import CoreData


extension Golfer {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Golfer> {
        return NSFetchRequest<Golfer>(entityName: "Golfer");
    }

    @NSManaged public var clubHandicap: NSDecimalNumber?
    @NSManaged public var firstName: String?
    @NSManaged public var membershipNumber: String?
    @NSManaged public var name: String?
    @NSManaged public var playingHandicap: NSNumber?
    @NSManaged public var scores: Dictionary<String, Int>//[String:Int]?
    @NSManaged public var surname: String?
    @NSManaged public var tuesdayHandicap: NSNumber?
    @NSManaged public var image: NSData?
    @NSManaged public var playsInA: Tournee?

}
