//
//  today.swift
//  TuesdayGolfClub
//
//  Created by Keith Bamford on 09/09/2016.
//  Copyright © 2016 AKA Consultants. All rights reserved.
//

import Foundation


extension NSDate {
    
    class func todayAsString() -> String {
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = .ShortStyle
        dateFormatter.timeStyle = .NoStyle
        
        let today = NSDate()
        
        // UK English Locale (en_GB)
        dateFormatter.locale = NSLocale(localeIdentifier: "en_GB")
        
        return dateFormatter.stringFromDate(today)
    }
    
    
    
}