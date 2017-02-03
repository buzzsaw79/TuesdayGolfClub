//
//  Tournee.swift
//  TuesdayGolfClub
//
//  Created by Keith Bamford on 02/09/2016.
//  Copyright © 2016 AKA Consultants. All rights reserved.
//

import Foundation
import CoreData



class Tournee: NSManagedObject {

    //MARK: -
    //MARK: Computed Properties

    var playerScore:[Golfer:Int]?
    
    let numberOfParThrees = 4

    //MARK: -
    //MARK: Tournee creation and life cycle
    class func createAndSaveTournee(with golfers:[Golfer], inManagedObjectContext context:NSManagedObjectContext) -> Tournee? {

        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Tournee")
        request.predicate = NSPredicate(format: "date < %@", Date() as CVarArg)
        
        if let tournee = (try? context.fetch(request))?.first as? Tournee {
            return tournee
        } else if let tournee = NSEntityDescription.insertNewObject(forEntityName: "Tournee", into: context) as? Tournee {
            
            tournee.date = Date() as NSDate?
            tournee.course = Constants.courses.but
            tournee.day = tournee.todayAsString()
            tournee.completed = false
            tournee.entryFee = NSDecimalNumber(value: Constants.Tournee.entryFee)
            tournee.scores = [Golfer:Int]() as NSObject?
            // add golfers to tournee
            tournee.mutableSetValue(forKey: "hasEntrants").addObjects(from: golfers)
            
            Tournee.saveTournee(tournee: tournee)
            
            return tournee
  
        }
 
        return nil
    }
    
    class func saveTournee(tournee: Tournee) {
        do {
            try tournee.managedObjectContext?.save()
        } catch let error {
            print("Unable to save within saveTournee func - ERROR: \(error)")
        }
    }
    
    func validateAndComplete() -> Bool {
        // Validate all data before saving
        
        return false
    }
    
    func addScores(dictionary: [String:Int]) -> Bool {
        return false
    }
    
    func calculatePrizeMoney(_ numberOfEntrants: Int, entranceFee: Int) -> Array<Double> {
        var prizes = [Double]()
        let totalPrizeMoney = Double(numberOfEntrants * entranceFee)
        let parThreePrizeMoney = Double(numberOfEntrants) * 0.5 * Double(numberOfParThrees)
        
        let pot = totalPrizeMoney - parThreePrizeMoney
        
        switch numberOfEntrants {
        case 1: prizes = [pot]
        case 2: prizes = [pot]
        case 3: prizes = [pot*0.65, pot*0.35]
        case 4: prizes = [pot*0.60, pot*0.40]
        case 5: prizes = [pot*0.55, pot*0.30, pot*0.15]
        case 6: prizes = [pot*0.55, pot*0.30, pot*0.15]
        case 7: prizes = [pot*0.50, pot*0.30, pot*0.10, pot*0.05]
        case 8: prizes = [pot*0.60, pot*0.25, pot*0.10, pot*0.05]
        case 9: prizes = [pot*0.50, pot*0.20, pot*0.14, pot*0.10, pot*0.06]
        case 10: prizes = [pot*0.50, pot*0.20, pot*0.14, pot*0.10, pot*0.06]
        default: prizes = [pot*0.50, pot*0.20, pot*0.14, pot*0.10, pot*0.06]
        }
        
        if numberOfEntrants % 2 == 0 {
            
        }
        
        return prizes
    }
    
    
    func calculateAvgScore(scores: [Int]) -> Double? {
        if !scores.isEmpty {
            var sum = 0.0
            for score in scores {
                sum += Double(score)
            }
            return sum / Double(scores.count)
        } else {
            return nil
        }
        
    }
    
    //MARK: -
    //MARK: Helper Functions
    
    func todayAsString() -> String? {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none
        
        let today = Date()
        let tomorrow = today.addingTimeInterval(60*60*24)
        // UK English Locale (en_GB)
        dateFormatter.locale = Locale(identifier: "en_GB")
        
        return dateFormatter.string(from: tomorrow)
    }
    
    fileprivate func dateAsString(_ date: Date) -> String? {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none
        
        // UK English Locale (en_GB)
        dateFormatter.locale = Locale(identifier: "en_GB")
        
        return dateFormatter.string(from: date)
    }
}
