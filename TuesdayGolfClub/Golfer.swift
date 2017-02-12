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

typealias Handicap = NSDecimalNumber

class Golfer: NSManagedObject {
    
    //MARK: -
    //MARK: Properties

    var members:[Golfer]? {
        get {
            return [Golfer]()
        }
    }
    
    var firstName: String {
        if let fullName = self.name?.components(separatedBy: " ") {
            return fullName.first!
        }
       return "No name"
    }
    
    var surname: String {
        if let fullName = self.name?.components(separatedBy: " ") {
            return fullName.last!
        }
        return "No name"
    }
    
    var playingHndcp: Int {
        get {
        
            let handicap = self.clubHandicap!.rounding(accordingToBehavior: nil)
            return Int.init(handicap)
            
        }
    }
    
    var playingHndcpAsString: String {
        get {
            
            let handicap = self.clubHandicap!.rounding(accordingToBehavior: nil)
            return String(describing: handicap)
            
        }
    }
    
    var golferDictionary: [String:Handicap] {
        
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
        
        let golferHandicaps:[Handicap] = [17.5, 17.1, 16.5, 26.1, 16.7, 16.4, 21.2, 17.8, 21.7, 25.5, 21.8, 16.2, 5.9, 11.4, 12.8, 13.8, 10.5, 18.4]
        
        var _golferDictionary = [String:Handicap]()
        
        if golferHandicaps.count == golferNames.count {
            for (index, aName) in golferNames.enumerated() {
                _golferDictionary.updateValue(golferHandicaps[index], forKey: aName)
            }
        }
        print(_golferDictionary)
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
//        golfer.playingHandicap = golfer.playingHndcp as NSNumber?
        
        golfer.image = UIImageJPEGRepresentation(image, 1.0) as NSData?

        return golfer
    }
    
    class func saveGolfer(golfer: Golfer) -> Bool {
        do {
            try golfer.managedObjectContext?.save()
            //print("\(golfer.name!)'s score saved!")
            return true
        } catch let error {
            print("Unable to save within saveGolfer func - ERROR: \(error)")
            return false
        }
    }
    
    
    class func fetchGolferWithName(_ name: String, inManagedObjectContext context: NSManagedObjectContext) -> Golfer? {

        let golferNameRequest = NSFetchRequest<NSFetchRequestResult>(entityName: Constants.Entity.golferEntityString)
        golferNameRequest.predicate = NSPredicate(format: "name = %@", name)
        
        if let golfer = (try? context.fetch(golferNameRequest))?.last as? Golfer {
            
            return golfer
        }
        return nil
    }
    
    //MARK: -
    //MARK: Methods
    
    func addScore(date: String, score: Int) -> Bool {
        if scores.updateValue(score, forKey: date) == nil {
            return true
        }
        return false
    }
    
    
    
}
