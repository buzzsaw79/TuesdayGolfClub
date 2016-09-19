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

class alert: NSObject {
    
    
    static func show(title: String, message: String, vc: UIViewController) {
        
        
        // Create the Controller
        let alertCtrl = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        
        //        alertCtrl.view.translatesAutoresizingMaskIntoConstraints = false
        
        // Create the lert Action
        let okAc = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default) {
            (alert: UIAlertAction) -> Void in
            alertCtrl.dismissViewControllerAnimated(true, completion: nil)
        }
        
        // Ad Alert Actions to lert Controller
        alertCtrl.addAction(okAc)
        
        // Display Alert Controller
        vc.presentViewController(alertCtrl, animated: true, completion: nil)
        
        
    }

    
}
