//
//  RateSessionViewController.swift
//  Eventerator
//
//  Created by Quinton Wall on 10/5/15.
//  Copyright © 2015 Quinton Wall. All rights reserved.
//

import UIKit

class RateSessionViewController: UIViewController {

    var currentSession : Session?
    
    @IBOutlet weak var sessionName: UILabel!
    @IBOutlet weak var averageRating: UILabel!
    @IBOutlet weak var ratingDescriptor: UILabel!

    @IBOutlet weak var rating1: UIButton!
    @IBOutlet weak var rating2: UIButton!
    @IBOutlet weak var rating3: UIButton!
    @IBOutlet weak var rating4: UIButton!
    @IBOutlet weak var rating5: UIButton!
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        if  !SFAuthenticationManager.sharedManager().haveValidSession {
            self.performSegueWithIdentifier("login", sender: self)
        }

        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        sessionName.text = currentSession?.name
        rating1.tag = 1
        rating2.tag = 2
        rating3.tag = 3
        rating4.tag = 4
        rating5.tag = 5
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("CURRENT SESSION: \(currentSession?.name)")
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func ratingTapped(sender: AnyObject) {
        print("SENDER \(sender.tag)")
        
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
