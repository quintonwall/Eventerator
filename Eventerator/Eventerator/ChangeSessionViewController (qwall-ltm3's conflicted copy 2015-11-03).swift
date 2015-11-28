//
//  ChangeSessionViewController.swift
//  Eventerator
//
//  Created by Quinton Wall on 10/5/15.
//  Copyright © 2015 Quinton Wall. All rights reserved.
//

import UIKit
import Alamofire




class ChangeSessionViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{

    
    @IBOutlet weak var resultsTable: UITableView!
    @IBOutlet weak var sessionNameTF: UITextField!
    @IBOutlet weak var speakerNameTF: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    
    var jsonResults : Eventerator.JSON?
    
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
        
        resultsTable.delegate = self
        resultsTable.dataSource = self
        
    }
    
    @IBAction func searchTapped(sender: AnyObject) {
        
        //SessionDelegate.searchForSession(speakerNameTF.text!, sessionname: sessionNameTF.text!)
        
        let request = SFRestAPI.sharedInstance().requestForQuery("select Average_Ratings__c, Event__r.Event_Name__c, Id, Name, Num_Ratings__c, Session_Name__c, SystemModstamp, Total_Ratings__c from Session__c WHERE Session_Name__c like \'%\(sessionNameTF.text!)%\' ORDER BY Session_Name__c")
        
        SFRestAPI.sharedInstance().sendRESTRequest(request, failBlock: { error in
            print("Problem getting sessions \(error)")
            
            }) { response in  //success
                //map session data here.
                print("SUCCESS: \(response)")
               self.jsonResults = JSON(response)
                
                
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.resultsTable.reloadData()
                })
              
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
    
    
    // MARK Table Delegates
    
    
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if jsonResults == nil {
            return 1
        } else {
            return self.jsonResults!["totalSize"].int!
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("SessionCell", forIndexPath: indexPath) as! SessionTableViewCell
        
        for (index,subJson):(String, JSON) in self.jsonResults!["records"] {
            print("INDEX: \(index)")
            cell.sessionId = subJson["Id"].string
            cell.sessionName.text = subJson["Session_Name__c"].string
            cell.rating.text = subJson["Average_Ratings__c"].string
        }
        
        return cell
    }
}
