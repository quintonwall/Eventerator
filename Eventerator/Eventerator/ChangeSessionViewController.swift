//
//  ChangeSessionViewController.swift
//  Eventerator
//
//  Created by Quinton Wall on 10/5/15.
//  Copyright © 2015 Quinton Wall. All rights reserved.
//

import UIKit
import Alamofire
import CoreData




class ChangeSessionViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate{

    
    @IBOutlet weak var resultsTable: UITableView!
    @IBOutlet weak var sessionNameTF: UITextField!
    @IBOutlet weak var speakerNameTF: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    
    var jsonResults : Eventerator.JSON?
    var selectedSession : Session?
    
    var localsessions = [Session]()
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        if  !SFAuthenticationManager.sharedManager().haveValidSession {
            self.performSegueWithIdentifier("login", sender: self)
        }
        
        //Name search not yet implemented
        speakerNameTF.enabled = false
        speakerNameTF.layer.borderWidth = 1
        speakerNameTF.layer.borderColor = UIColor.whiteColor().CGColor
        

        sessionNameTF.layer.borderWidth = 1
        sessionNameTF.layer.borderColor = UIColor.whiteColor().CGColor
        sessionNameTF.becomeFirstResponder()  //set initial focus
        
        //register to handle RETURN
        speakerNameTF.delegate = self
        sessionNameTF.delegate = self
        
        resultsTable.delegate = self
        resultsTable.dataSource = self
        
        
    }
    
     func textFieldShouldReturn(textField: UITextField) -> Bool{
        searchTapped(self)
        return true
    }
    
    @IBAction func searchTapped(sender: AnyObject) {
        
        //SessionDelegate.searchForSession(speakerNameTF.text!, sessionname: sessionNameTF.text!)
        
        let request = SFRestAPI.sharedInstance().requestForQuery("select Average_Rating__c, Event__r.Event_Name__c, Id, Name, Number_of_Ratings__c, Session_Name__c, SystemModstamp, Total_Ratings__c from Session__c WHERE Session_Name__c like \'%\(sessionNameTF.text!)%\' ORDER BY Session_Name__c")
        
        SFRestAPI.sharedInstance().sendRESTRequest(request, failBlock: { error in
            print("Problem getting sessions \(error)")
            
            }) { response in  //success
                
               self.jsonResults = JSON(response)
                
                  //example of looping salesforce results using swiftyjson
                  // for (index,subJson):(String, JSON) in self.jsonResults!["records"] {
                  //  var s = subJson["Session_Name__c"]
                  //}

                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.resultsTable.reloadData()
                })
        }
    }
    
    
    override func viewWillAppear(animated: Bool) {
   
        super.viewWillAppear(animated)
        //clear old results from the table
       jsonResults = nil
        fetchLocalSessions()
        self.resultsTable.reloadData()
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

       override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "ratesession") {
            let svc = segue.destinationViewController as! RateSessionViewController
            svc.currentSession = selectedSession
            
        }
    }
    
    // MARK: Core data methods
    func fetchLocalSessions() {
        
        localsessions = [Session]()
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest = NSFetchRequest(entityName: "Session")
        
        do {
            let results =
            try managedContext.executeFetchRequest(fetchRequest)
            
            for s : Session in results as! [Session] {
                s.dump()
                localsessions.append(s)
                
            }
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        
    }

    
    // MARK Table Delegates
    
    
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if jsonResults == nil {
            return 0
        } else {
            return self.jsonResults!["totalSize"].int!
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("SessionCell", forIndexPath: indexPath) as! SessionTableViewCell
        
               for s : Session in localsessions {
            let id = jsonResults!["records"][indexPath.row]["Id"].string
            
            if( s.salesforceId == id) {
                cell.userInteractionEnabled = false
                cell.selectionStyle = UITableViewCellSelectionStyle.None
                cell.isAlreadyLocal = true
                cell.isLocalImage.image = UIImage(named: "cloud-download")
                cell.backgroundColor = UIColor.lightGrayColor()
                
            }
        }
        
       cell.sessionId = jsonResults!["records"][indexPath.row]["Id"].string
       cell.sessionName.text = jsonResults!["records"][indexPath.row]["Session_Name__c"].string
       cell.rating.text = jsonResults!["records"][indexPath.row]["Average_Rating__c"].string
 
        return cell
    }
    
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
        NSLog("You selected cell number: \(indexPath.row)!")
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
        selectedSession = NSEntityDescription.insertNewObjectForEntityForName("Session", inManagedObjectContext: managedContext) as! Session
        
        selectedSession?.salesforceId = jsonResults!["records"][indexPath.row]["Id"].string
        selectedSession?.name = jsonResults!["records"][indexPath.row]["Session_Name__c"].string
        //selectedSession?.numOfRatings = jsonResults!["records"][indexPath.row]["Number_of_Ratings__c"].int
        selectedSession?.previousNumberOfRatingsFromCloud = jsonResults!["records"][indexPath.row]["Total_Ratings__c"].int
        selectedSession?.averageRating = jsonResults!["records"][indexPath.row]["Average_Rating__c"].double
        
        self.tabBarController?.selectedIndex = 0
        self.performSegueWithIdentifier("localsessions", sender: self)
    }
}
