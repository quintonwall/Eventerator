//
//  Session.swift
//  Eventerator
//
//  Created by Quinton Wall on 11/2/15.
//  Copyright © 2015 Quinton Wall. All rights reserved.
//

import Foundation


class Session: NSObject {
    
    var salesforceId: String?
    var eventName: String?
    var name : String?
    var speakers = [String]()
    var numOfRatings: Int!
    var totalOfRatings: Int!
    
    var avgRating: Double! {
        didSet {
            if avgRating == nil {
                avgRating = 0
            }
        }
    }
    
    override init() {
        //self.avgRating = 0
    }
    
    func addRating(rating: Int) -> Double{
        numOfRatings! += 1
        totalOfRatings! += rating
        avgRating = Double(totalOfRatings!) / Double(numOfRatings!)
        
        return avgRating!
    }
    
    func dump() {
        print("CURRENT SESSION: name=\(name), num ratings=\(numOfRatings), total ratings=\(totalOfRatings), avg rating=\(avgRating)")
    }
    
    
    func avgRatingAsNonOptionalString() -> String {
        //use the double extension to round
        if let r = avgRating?.roundToPlaces(2) {
            return String(r)
        }
        else {
           return "0.0"
        }
    }

}