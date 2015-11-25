//
//  LocalSessionViewCell.swift
//  Eventerator
//
//  Created by Quinton Wall on 11/25/15.
//  Copyright © 2015 Quinton Wall. All rights reserved.
//

import UIKit

class LocalSessionViewCell: UICollectionViewCell {

    @IBOutlet weak var sessionName: UILabel!
    @IBOutlet weak var currentRating: UILabel!
    
    
    @IBOutlet weak var continueRatingButton: UIButton!
    @IBOutlet weak var syncToCloudButton: UIButton!
    
    var salesforceId : String?
    
    
}
