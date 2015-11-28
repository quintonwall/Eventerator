//
//  Session.swift
//  Eventerator
// track a batch of ratings. This gets reset whenever we sync
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
    @NSManaged var previousNumberOfRatingsFromCloud: NSNumber!
    
    @NSManaged var averageRating: NSNumber!
    
    
    func addRating(rating: Int) -> Double{
        numOfRatings! = Int(numOfRatings) + 1
        totalOfRatings!  = Int(totalOfRatings) + rating
        averageRating = Double(totalOfRatings!) / Double(numOfRatings!)
        
        return Double(averageRating!)
    }
    
    func dump() {
        print("CURRENT SESSION: name=\(name), num ratings=\(numOfRatings), total ratings since sync=\(previousNumberOfRatingsFromCloud), avg rating in batch=\(averageRating)")
    }
    
    //mobile sdk likes an NSDictionary to insert into salesforce
    func getDictionaryForCloudInsert() -> NSDictionary {
        let d : NSDictionary = [
            "Session__c" : salesforceId!,
            "Total_Ratings_in_Batch__c" : totalOfRatings!,
            "Averate_Rating_For_Batch__c" : averageRating!,
            "Number_of_Ratings_in_Batch__c" : numOfRatings!,
            "Device_Identifier__c" : UIDevice.currentDevice().identifierForVendor!.description
        
        ]
        
        return d
    }
    
    func numberAsNonOptionalString(value: NSNumber) -> String {
        return String(value)
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