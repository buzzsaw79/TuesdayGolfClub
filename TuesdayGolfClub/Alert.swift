//
//  Alert.swift
//  TuesdayGolfClub
//
//  Created by Keith Bamford on 09/09/2016.
//  Copyright © 2016 AKA Consultants. All rights reserved.
//


import Foundation
import UIKit
import CoreData




struct Constants {
    
    struct golferNames {
        static let alan = "Alan Bromley"
        static let bernie = "Bernard Bull"
        static let keith = "Keith Bamford"
        static let mick = "Mick Clarke"
        static let mario = "Mario DeAbreu"
        static let jimmy = "Jimmy Sweeney"
        static let graham = "Graham Clarke"
        static let john = "John Cashman"
        static let jeff = "Jeff Mabbitt"
        static let nigel = "Nigel Maqueline"
        static let jonny = "John Bolton"
        static let adrian = "Adrian Harding"
        static let dan = "Daniel DeAbreu"
        static let james = "James DeAbreu"
        static let steve = "Steve DeAbreu"
        static let downsie = "Steve Downs"
        static let kenny = "Kenny Barratt"
        static let daFish = "Jimmy Simms"
    }
    
    struct courses {
        static let mack = "Mackintosh"
        static let but = "Button"
    }
    
    struct numbers {
        static let maxGolfersInGroup = 4
    }
    
    struct Storyboard {
        static let EnterScoreCellIdentifier = "EnterScoreCell"
    }
    
    struct Entity {
        static let golferEntityString = "Golfer"
        static let tourneeEntityString = "Tournee"
    }
    
    struct Tournee {
        static let entryFee = 9
        
    }
    
}

class alert: NSObject {
    
    
    static func show(_ title: String, message: String, vc: UIViewController) {
        
        
        // Create the Controller
        let alertCtrl = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        //        alertCtrl.view.translatesAutoresizingMaskIntoConstraints = false
        
        // Create the alert Action
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
            (alert: UIAlertAction) -> Void in
            alertCtrl.dismiss(animated: true, completion: nil)
        }
        
        // Ad Alert Actions to lert Controller
        alertCtrl.addAction(okAction)
        
        // Display Alert Controller
        vc.present(alertCtrl, animated: true, completion: nil)
        
        
    }

    
}
