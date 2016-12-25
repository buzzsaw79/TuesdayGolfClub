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
            for (index, aName) in golferNames.enumerated() {
                self.golferDictionary.updateValue(golferHandicaps[index], forKey: aName)
                
            }
        }
        
        
        }
    }
    
    static func createGolfers() {
        
    }

    class func golferInTournee(_ tournee: Tournee, inManagedObjectContext context: NSManagedObjectContext) -> Golfer? {
        // DEBUG
        //print("Golfer.golferInTournee")
        
        let golferRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Golfer")
        
        if let golfer = tournee.hasEntrants?.allObjects[0] as! Golfer? {
        
        golferRequest.predicate = NSPredicate(format: "membershipNumber = %@", golfer.membershipNumber!)
        
        
        }
        
        
        
        
        return nil
    }
    
    
    class func fetchGolferWithName(_ name: String, inManagedObjectContext context: NSManagedObjectContext) -> Golfer? {
        // DEBUG
        //print("Golfer.fetchGolferWithName")
        
        
        let golferNameRequest = NSFetchRequest<NSFetchRequestResult>(entityName: Constants.Entity.golferEntityString)
        golferNameRequest.predicate = NSPredicate(format: "name = %@", name)
        
        if let golfer = (try? context.fetch(golferNameRequest))?.last as? Golfer {
            // Tournee() producing null results
            
            if let tourneeDescription = NSEntityDescription.entity(forEntityName: "Tournee", in: context)
            {
                
              let tourneeRequest = NSFetchRequest<NSFetchRequestResult>(entityName: Constants.Entity.tourneeEntityString)
                tourneeRequest.predicate = NSPredicate(format: "day = %@", Date.todayAsString())
                
                do {
                    try context.fetch(tourneeRequest)
                } catch {
                    
                }
                
                
                
//            let newTournee = Tournee(entity: tourneeDescription,
//                                          insertIntoManagedObjectContext: context)
//                newTournee.course = Constants.courses.mack
//                newTournee.date = NSDate()
//                newTournee.day = NSDate.todayAsString()
//                newTournee.entryFee = 9
//                newTournee.mutableSetValueForKey("hasEntrants").addObject(golfer)
                
//            ÷
//            Golfer.golferInTournee(newTournee, inManagedObjectContext: golfer.managedObjectContext!)
            }
            return golfer
        }
        return nil
    }
}
