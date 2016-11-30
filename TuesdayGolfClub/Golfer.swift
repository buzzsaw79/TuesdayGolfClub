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
    
    //MARK: -
    //MARK: Init
    var members:[Golfer]? {
        get {
            return [Golfer]()
        }
    }
    
    var golferDictionary: [String:Double] {
        get {
            return [String:Double]()
        } set {
        // Test Data....
        let golferNames = ["Keith Bamford", "Alan Bromley", "Mick Clarke", "Graham Clarke", "Gary Davies","Graham Hill"]
        let golferHandicaps = [18.7, 17.8, 20.2, 20.1, 10.7, 18.4]
        
        if golferHandicaps.count == golferNames.count {
            for (index, aName) in golferNames.enumerate() {
                self.golferDictionary.updateValue(golferHandicaps[index], forKey: aName)
                
            }
        }
        
        
        }
    }
    
    static func createGolfers() {
        
    }

    class func golferInTournee(tournee: Tournee, inManagedObjectContext context: NSManagedObjectContext) -> Golfer? {
        
        print("Golfer.golferInTournee")
        
        let golferRequest = NSFetchRequest(entityName: "Golfer")
        
        if let golfer = tournee.hasEntrants?.allObjects[0] as! Golfer? {
        
        golferRequest.predicate = NSPredicate(format: "membershipNumber = %@", golfer.membershipNumber!)
        
        
        }
        
        
        
        
        return nil
    }
    
    
    class func fetchGolferWithName(name: String, inManagedObjectContext context: NSManagedObjectContext) -> Golfer? {
        
        print("Golfer.fetchGolferWithName")
        
        
        let golferNameRequest = NSFetchRequest(entityName: "Golfer")
        golferNameRequest.predicate = NSPredicate(format: "name = %@", name)
        
        if let golfer = (try? context.executeFetchRequest(golferNameRequest))?.last as? Golfer {
            // Tournee() producing null results
            
            if let tourneeDescription = NSEntityDescription.entityForName("Tournee", inManagedObjectContext: context)
            {
            let newTournee = Tournee(entity: tourneeDescription,
                                          insertIntoManagedObjectContext: context)
                newTournee.course = Constants.courses.mack
                newTournee.date = NSDate()
                newTournee.day = NSDate.todayAsString()
                newTournee.entryFee = 9
                newTournee.mutableSetValueForKey("hasEntrants").addObject(golfer)
                
            
            Golfer.golferInTournee(newTournee, inManagedObjectContext: golfer.managedObjectContext!)
            }
            return golfer
        }
        return nil
    }
}
