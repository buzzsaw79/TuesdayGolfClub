//
//  today.swift
//  TuesdayGolfClub
//
//  Created by Keith Bamford on 09/09/2016.
//  Copyright © 2016 AKA Consultants. All rights reserved.
//

import Foundation


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
    
    
    
}







