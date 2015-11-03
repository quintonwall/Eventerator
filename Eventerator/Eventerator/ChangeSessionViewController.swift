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

    
    @IBOutlet weak var resultsTable: UITableView!
    @IBOutlet weak var sessionNameTF: UITextField!
    @IBOutlet weak var speakerNameTF: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        if SFUserAccountManager.sharedInstance().currentUser.userName.isEmpty {
            self.performSegueWithIdentifier("login", sender: self)
        }
        
        //Name search not yet implemented
        speakerNameTF.enabled = false
        speakerNameTF.layer.borderWidth = 1
        speakerNameTF.layer.borderColor = UIColor.whiteColor().CGColor

        sessionNameTF.layer.borderWidth = 1
        sessionNameTF.layer.borderColor = UIColor.whiteColor().CGColor
        
    }
    
    @IBAction func searchTapped(sender: AnyObject) {
        
        //SessionDelegate.searchForSession(speakerNameTF.text!, sessionname: sessionNameTF.text!)
        
        let request = SFRestAPI.sharedInstance().requestForQuery("select Average_Ratings__c, Event__r.Event_Name__c, Id, Name, Num_Ratings__c, Session_Name__c, SystemModstamp, Total_Ratings__c from Session__c WHERE Session_Name__c like \'%\(sessionNameTF.text!)%\' ORDER BY Session_Name__c")
        
        SFRestAPI.sharedInstance().sendRESTRequest(request, failBlock: { error in
            print("Problem getting sessions \(error)")
            
            }) { response in  //success
                //map session data here.
                print("SUCCESS: \(response)")
        }

        
        /*
        Alamofire.request(.GET, "/v34.0/sobjects/SObject/Session__c")
            .responseString { response in
                print("Response String: \(response.result.value)")
            }
            .responseJSON { response in
                print("Response JSON: \(response.result.value)")
        }
        */
        
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
