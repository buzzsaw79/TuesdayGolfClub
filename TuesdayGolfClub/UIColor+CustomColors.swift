//
//  UIColor+CustomColors.swift
//  tourKeeprNSDefaults
//
//  Created by Keith Bamford on 14/03/2016.
//  Copyright © 2016 AKA Consultants. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
    public class func grassGreenColour() -> UIColor {
        return UIColor(red: 0.4, green: 0.54, blue: 0.19, alpha: 1.0) // Another Green
    }
//    public class func evenCellColour() -> UIColor {
//        return UIColor(red: 0.918, green: 0.902, blue: 0.792, alpha: 1) // Oyster White
//    }
    
    public class func evenCellColour() -> UIColor {
        return UIColor(red: 0.958, green: 0.942, blue: 0.832, alpha: 0.8) // Oyster White
    }
    
    public class func oddCellColour() -> UIColor {
        return UIColor(red: 0.537, green: 0.675, blue: 0.463, alpha: 1.0) // Pale Green
    }
    public class func oddCellTextColour() -> UIColor {
        return UIColor(red: 0.958, green: 0.952, blue: 0.852, alpha: 1) // Green
    }
    public class func evenCellTextColour() -> UIColor {
        return UIColor(red: 0.357, green: 0.495, blue: 0.283, alpha: 1.0) // Pale Green
    }
    
    public class func footerColour() -> UIColor {
        return UIColor(red: 0.424, green: 0.443, blue: 0.337, alpha: 1.0) // Reed Green
    }
    
    public class func nameLabelTextColour() -> UIColor {
        return UIColor(red: 0.8, green: 0.4, blue: 0.4, alpha: 1.0)
    }
    
    public class func headerColour() -> UIColor {
//        return UIColor(red: 0.298, green: 0.569, blue: 0.255, alpha: 1.0)
        
        return UIColor(red:0.18, green:0.80, blue:0.44, alpha:1.0)
    }
    
    public class func richRed() -> UIColor {
        return UIColor(red: 0.66, green: 0.12, blue: 0.09, alpha: 1.0)
    }

    public class func eggShell() -> UIColor {
        return UIColor(red: 0.64, green: 0.77, blue: 0.79, alpha: 1.0)
    }
    public class func doveSlate() -> UIColor {
        return UIColor(red: 0.67, green: 0.73, blue: 0.74, alpha: 1.0)
    }
}
