//
//  Double.swift
//  Eventerator
//
//  Created by Quinton Wall on 11/9/15.
//  Copyright © 2015 Quinton Wall. All rights reserved.
//

import Foundation


extension Double {
    /// Rounds the double to decimal places value
    func roundToPlaces(places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return round(self * divisor) / divisor
    }
}