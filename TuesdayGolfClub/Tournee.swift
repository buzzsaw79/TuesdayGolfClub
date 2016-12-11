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
    
    
    
//    enum courseString: String {
//        case MAC = "Mackintosh"
//        case BUT = "Button"
//    }
    
    var playerScore:[Golfer:Int] {
        return [Golfer:Int]()
    }
    
    
    
    //MARK: -
    //MARK: Golfer creation and life cycle
//    class func tourneeWithGolfers(golfers:[Golfer], inManagedObjectContext context:NSManagedObjectContext) -> Tournee? {
//        
//        let today = NSDate()
//        
//        
//        
//        let request = NSFetchRequest(entityName: "Tournee")
//        request.predicate = NSPredicate(format: "date < %@", today)
//        
//        if let tournee = (try? context.executeFetchRequest(request))?.first as? Tournee {
//            return tournee
//        } else if let tournee = NSEntityDescription.insertNewObjectForEntityForName("Tournee", inManagedObjectContext: context) as? Tournee {
//            
//            tournee.date = today
//            tournee.course = self.courseString.BUT.rawValue
//            tournee.day = tournee.todayAsString()
//            
//            for golfer in golfers {
//                //tournee.mutableSetValueForKey("hasEntrants").addObject(golfer)
//                // company.mutableSetValueForKey("hasEntrants").addObject(employees)
//                golfer.playsInA = tournee
//
//            }
//            
//            do {
//                try context.save()
//            } catch let error {
//                print("Unable to save within tourneeWithGolfers: \(error)")
//            }
//            // Debug
//            //print("TOURNEE: \(tournee.hasEntrants)")
//            return tournee
//  
//        }
//        
//        
//        
//        return nil
//    }
    

    
    //MARK: -
    //MARK: Helper Functions
    
    private func todayAsString() -> String? {
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = .ShortStyle
        dateFormatter.timeStyle = .NoStyle
        
        let today = NSDate()
        
        // UK English Locale (en_GB)
        dateFormatter.locale = NSLocale(localeIdentifier: "en_GB")
        
        return dateFormatter.stringFromDate(today)
    }
    
    private func dateAsString(date: NSDate) -> String? {
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = .ShortStyle
        dateFormatter.timeStyle = .NoStyle
        
        // UK English Locale (en_GB)
        dateFormatter.locale = NSLocale(localeIdentifier: "en_GB")
        
        return dateFormatter.stringFromDate(date)
    }
}
