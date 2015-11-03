//
//  SettingsViewController.swift
//  Eventerator
//
//  Created by Quinton Wall on 10/5/15.
//  Copyright © 2015 Quinton Wall. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var logoutButton: UIButton!
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        if  !SFAuthenticationManager.sharedManager().haveValidSession {
            self.performSegueWithIdentifier("login", sender: self)
        }

        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

     
    }
    
    @IBAction func logoutTapped(sender: AnyObject) {
       let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setBool(false, forKey: Constants.LOGGEDIN)
        defaults.setValue("", forKey: Constants.AUTH_TOKEN)
        self.performSegueWithIdentifier("login", sender: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
