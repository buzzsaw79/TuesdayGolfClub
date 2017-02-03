//
//  today.swift
//  TuesdayGolfClub
//
//  Created by Keith Bamford on 09/09/2016.
//  Copyright © 2016 AKA Consultants. All rights reserved.
//

import Foundation
import UIKit


extension Date {
    
    static func todayAsString() -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none
        
        let today = Date()
        
        // UK English Locale (en_GB)
        dateFormatter.locale = Locale(identifier: "en_GB")
        
        return dateFormatter.string(from: today)
    }
    
    static func dateAsString(_ date: Date) -> String? {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none
        
        // UK English Locale (en_GB)
        dateFormatter.locale = Locale(identifier: "en_GB")
        
        return dateFormatter.string(from: date)
    }
    
    var tomorrow: Date {
        let tomorrow = Date().addingTimeInterval(60*60*24)
        return tomorrow
    }
    
    
    var weekToday: Date {
        let weekToday = Date().addingTimeInterval(60*60*24*7)
        return weekToday
    }
  
    
}













//    @IBAction func addGolfer(_ sender: UIBarButtonItem) {
//
//        // Create AlertController
//        let alert = UIAlertController(title: "Add Golfer", message: nil, preferredStyle: .alert)
//
//        // Add Textfield to Alert
//        alert.addTextField { (golferName) -> Void in
//
//            golferName.placeholder = "Enter Golfer Name"
//        }
//
//        // Add another Textfield to Alert
//        alert.addTextField { (golferHandicap) -> Void in
//            golferHandicap.placeholder = "Enter Golfer Handicap"
//        }
//        // the add action for the textfield
//        let addAction = UIAlertAction(title: "Add", style: .default) { _ in
//            let entity = NSEntityDescription.entity(forEntityName: Constants.Entity.golferEntityString, in: self.context)
//            let golfer = Golfer(entity: entity!, insertInto: self.context)
//            let nameTextField = alert.textFields?.first
//            let handicapTextField = alert.textFields?.last
//            golfer.name = nameTextField?.text
//
//
//            golfer.membershipNumber = "123456"
//            golfer.clubHandicap = NSDecimalNumber(string: handicapTextField?.text)
//            golfer.playingHandicap = golfer.clubHandicap?.rounding(accordingToBehavior: nil)
//            //            golfer.playsInA = Tournee.tourneeContainingGolfer(golfer)
//
//
//
//            if let fullName = golfer.name?.components(separatedBy: " ") {
//
//                golfer.firstName = fullName.first!
//                golfer.surname = fullName.last!
//
//            }
//
//
//            do {
//                try self.context.save()
//            } catch let error as NSError {
//                print("Error saving golfer \(error.localizedDescription)")
//            }
//        }
//
//        // the cancel action for the textfield
//        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
//
//        // add the actions to the alert
//        alert.addAction(cancelAction)
//        alert.addAction(addAction)
//
//        // present the alert
//        self.present(alert, animated: true, completion: nil)
//    }





