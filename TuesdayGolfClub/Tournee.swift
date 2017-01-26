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
    class func tourneeWith(_ golfers:[Golfer], inManagedObjectContext context:NSManagedObjectContext) -> Tournee? {
        
        let today = Date()
        
        
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Tournee")
        request.predicate = NSPredicate(format: "date < %@", today as CVarArg)
        
        if let tournee = (try? context.fetch(request))?.first as? Tournee {
            return tournee
        } else if let tournee = NSEntityDescription.insertNewObject(forEntityName: "Tournee", into: context) as? Tournee {
            
            tournee.date = today
            tournee.course = Constants.courses.but
            tournee.day = tournee.todayAsString()
            tournee.completed = false
            tournee.entryFee = 9
            tournee.scores = [Golfer:Int]()
            
            tournee.mutableSetValue(forKey: "hasEntrants").addObjects(from: golfers)
            
            for golfer in golfers {
                

                tournee.mutableSetValue(forKey: "hasEntrants").add(golfer)
                // company.mutableSetValueForKey("hasEntrants").addObject(employees)
                golfer.playsInA = tournee

            }
            
            do {
                try context.save()
            } catch let error {
                print("Unable to save within tourneeWithGolfers: \(error)")
            }
            
            return tournee
  
        }
        
        
        
        return nil
    }
    
    func calculatePrizeMoney(_ numberOfEntrants: Int, entranceFee: Int) -> Array<Double> {
        var prizes = [Double]()
        let totalPrizeMoney = Double(numberOfEntrants * entranceFee)
        let parThreePrizeMoney = Double(numberOfEntrants) * 0.5 * Double(numberOfParThrees)
        
        let pot = totalPrizeMoney - parThreePrizeMoney
        
        switch numberOfEntrants {
        case 1:
            prizes = [pot]
        case 2:
            prizes = [pot, 0.0]
        default:
            prizes = [1]
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
        
        // UK English Locale (en_GB)
        dateFormatter.locale = Locale(identifier: "en_GB")
        
        return dateFormatter.string(from: today)
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
