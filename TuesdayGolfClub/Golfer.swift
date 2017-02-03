//
//  Golfer.swift
//  TuesdayGolfClub
//
//  Created by Keith Bamford on 30/08/2016.
//  Copyright © 2016 AKA Consultants. All rights reserved.
//

import Foundation
import CoreData
import UIKit // Not good OOP



class Golfer: NSManagedObject {
    
    //MARK: -
    //MARK: Properties

    var members:[Golfer]? {
        get {
            return [Golfer]()
        }
    }
    
    var golferDictionary: [String:Double] {
        
        // Test Data....
        let golferNames = ["Keith Bamford",
                           "Kenny Barratt",
                           "Alan Bromley",
                           "Bernard Bull",
                           "John Bolton",
                           "John Cashman",
                           "Graham Clarke",
                           "Mick Clarke",
                           "Dan DeAbreu",
                           "James DeAbreu",
                           "Mario DeAbreu",
                           "Steve DeAbreu",
                           "Steve Downs",
                           "Adrian Harding",
                           "Nigel Maqueline",
                           "Jeff Mabbitt",
                           "Jimmy Simms",
                           "Jimmy Sweeney"]
        
        let golferHandicaps = [17.5, 17.1, 16.5, 26.1, 16.7, 16.4, 21.2, 17.8, 21.7, 25.5, 21.8, 16.2, 5.9, 11.4, 12.8, 13.8, 10.5, 18.4]
        
        var _golferDictionary = [String:Double]()
        
        if golferHandicaps.count == golferNames.count {
            for (index, aName) in golferNames.enumerated() {
                _golferDictionary.updateValue(golferHandicaps[index], forKey: aName)
            }
        }
        return _golferDictionary
        
    }
    
    private func makeGolferWith(name: String, handicap: Double) {
//        let golfer = Golfer.createNewGolfer(with: nil, name: name, handicap: handicap, membershipNo: nil, inManagedObjectContext: <#T##NSManagedObjectContext#>)
    }
    
    //MARK: -
    //MARK: Class Functions
    
    class func createNewGolfer(with image: UIImage, name: String, handicap: Double, membershipNo: String, inManagedObjectContext: NSManagedObjectContext) -> Golfer {
        // Check if golfer exists first LATER
        
        let entity = NSEntityDescription.entity(forEntityName: Constants.Entity.golferEntityString, in: inManagedObjectContext)
        let golfer = Golfer(entity: entity!, insertInto: inManagedObjectContext)
        
        golfer.name = name
        
        
        golfer.membershipNumber = membershipNo
        golfer.clubHandicap = NSDecimalNumber(value: handicap)
        golfer.playingHandicap = golfer.clubHandicap?.rounding(accordingToBehavior: nil)
        //            golfer.playsInA = Tournee.tourneeContainingGolfer(golfer)
        
        golfer.image = UIImageJPEGRepresentation(image, 1.0) as NSData?
        
        if let fullName = golfer.name?.components(separatedBy: " ") {
            
            golfer.firstName = fullName.first!
            golfer.surname = fullName.last!
            
        }

        return golfer
    }
    
    class func saveGolfer(golfer: Golfer) -> Bool {
        do {
            try golfer.managedObjectContext?.save()
            print("\(golfer.name!)'s score saved!")
            return true
        } catch let error {
            print("Unable to save within saveGolfer func - ERROR: \(error)")
            return false
        }
    }
    
    
    
    
    

    class func golferInTournee(_ tournee: Tournee, inManagedObjectContext context: NSManagedObjectContext) -> Golfer? {
        // DEBUG
        //print("Golfer.golferInTournee")
        
        let golferRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Golfer")
        
        if let golfer = tournee.hasEntrants?.allObjects[0] as! Golfer? {
        
        golferRequest.predicate = NSPredicate(format: "name = %@", golfer.name!)
        
        
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
                    // Handle ERROR
                }

            }
            return golfer
        }
        return nil
    }
    
    //MARK: -
    //MARK: Methods
    
    func addScore(date: String, score: Int) -> Bool {
        return false
    }
    
    
    
}
