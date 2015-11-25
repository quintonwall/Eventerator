//
//  Session.swift
//  Eventerator
//
//  Created by Quinton Wall on 11/2/15.
//  Copyright © 2015 Quinton Wall. All rights reserved.
//

import Foundation
import CoreData


class Session:NSManagedObject {
    
    @NSManaged var salesforceId: String?
    @NSManaged var eventName: String?
    @NSManaged var name : String?
    var speakers = [String]()
    @NSManaged var numOfRatings: NSNumber!
    @NSManaged var totalOfRatings: NSNumber!
    
    @NSManaged var averageRating: NSNumber!
    
    
    func addRating(rating: Int) -> Double{
        numOfRatings! = Int(numOfRatings) + 1
        totalOfRatings!  = Int(totalOfRatings) + rating
        averageRating = Double(totalOfRatings!) / Double(numOfRatings!)
        
        return Double(averageRating!)
    }
    
    func dump() {
        print("CURRENT SESSION: name=\(name), num ratings=\(numOfRatings), total ratings=\(totalOfRatings), avg rating=\(averageRating)")
    }
    
    
    func avgRatingAsNonOptionalString() -> String {
        //use the double extension to round
    
        if averageRating == nil {
            averageRating = 0.0
        }
        
        let avg = Double(averageRating)
        
        return String(avg.roundToPlaces(2))
        
            /*
        if let r = avg.roundToPlaces(2) {
            return String(r)
        }
        else {
           return "0.0"
        }
*/
    }


}