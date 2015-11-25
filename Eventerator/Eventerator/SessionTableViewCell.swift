//
//  SessionTableViewCell.swift
//  Eventerator
//
//  Created by Quinton Wall on 11/3/15.
//  Copyright © 2015 Quinton Wall. All rights reserved.
//
// Store the results of the session information returned from a search

import UIKit

class SessionTableViewCell: UITableViewCell {

    @IBOutlet weak var sessionName: UILabel!
    @IBOutlet weak var speaker: UILabel!
    @IBOutlet weak var rating: UILabel!
    var sessionId : String!
    var isAlreadyLocal : Bool = false 
    
    @IBOutlet weak var isLocalImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
