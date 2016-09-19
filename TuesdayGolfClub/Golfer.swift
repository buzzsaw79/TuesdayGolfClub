//
//  Golfer.swift
//  TuesdayGolfClub
//
//  Created by Keith Bamford on 30/08/2016.
//  Copyright © 2016 AKA Consultants. All rights reserved.
//

import Foundation
import CoreData


class Golfer: NSManagedObject {

    class func golferInTournee(tournee: Tournee, inManagedObjectContext context: NSManagedObjectContext) -> Golfer? {
        
        let golferRequest = NSFetchRequest(entityName: "Golfer")
        
        if let golfer = tournee.hasEntrants?.allObjects[0] as! Golfer? {
        
        golferRequest.predicate = NSPredicate(format: "membershipNumber = %@", golfer.membershipNumber!)
        
        
        }
        
        
        
        
        return nil
    }
}
