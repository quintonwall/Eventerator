//
//  ChangeSessionViewController.swift
//  Eventerator
//
//  Created by Quinton Wall on 10/5/15.
//  Copyright © 2015 Quinton Wall. All rights reserved.
//

import UIKit
import Alamofire

class ChangeSessionViewController: UIViewController {

    
    @IBOutlet weak var sessionNameTF: UITextField!
    @IBOutlet weak var speakerNameTF: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        let defaults = NSUserDefaults.standardUserDefaults()
        
        if !defaults.boolForKey(Constants.LOGGEDIN) {
            self.performSegueWithIdentifier("login", sender: self)
        }
        
    }
    
    @IBAction func searchTapped(sender: AnyObject) {
        
        
        Alamofire.request(.GET, "/v34.0/sobjects/SObject/Session__c")
            .responseString { response in
                print("Response String: \(response.result.value)")
            }
            .responseJSON { response in
                print("Response JSON: \(response.result.value)")
        }
        
    }
        
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
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