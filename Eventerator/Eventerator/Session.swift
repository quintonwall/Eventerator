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
    var avgRating: Double = 0.0
}