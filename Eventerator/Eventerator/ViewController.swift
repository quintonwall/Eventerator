//
//  ViewController.swift
//  Eventerator

// disply the list of sessions that are currently in progress (which are stored locally with core data)
//
//
//  Created by Quinton Wall on 10/5/15.
//  Copyright © 2015 Quinton Wall. All rights reserved.
//  Uses https://github.com/PhamBaTho/BTNavigationDropdownMenu
//

import UIKit
import CoreData

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
 
    @IBOutlet weak var sessionsCollectionView: UICollectionView!
    var sessions = [Session]()
    var selectedSession : Session?
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        
        if  !SFAuthenticationManager.sharedManager().haveValidSession {
            self.performSegueWithIdentifier("login", sender: self)
        }

    }
    
    override func viewWillAppear(animated: Bool) {
        //fetch the existing, not synced records from core data
        if  SFAuthenticationManager.sharedManager().haveValidSession {
            sessionsCollectionView.userInteractionEnabled = true
            self.view.userInteractionEnabled = true
            fetchLocalSessions()
            self.sessionsCollectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.navigationController?.navigationBar.translucent = false
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 0.0/255.0, green:180/255.0, blue:220/255.0, alpha: 1.0)
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    
    // MARK: Core data methods
    func fetchLocalSessions() {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest = NSFetchRequest(entityName: "Session")
        
        do {
            let results =
            try managedContext.executeFetchRequest(fetchRequest)
            
            for s : Session in results as! [Session] {
                s.dump()
                sessions.append(s)
               
            }
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        
    }
    
    func syncSessionWithSalesforce() {
        
    }
    
    func deleteLocalSession() {
        
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "ratesession") {
            let svc = segue.destinationViewController as! RateSessionViewController
            svc.currentSession = selectedSession
            
        }
    }
    
    
    //MARK: collectionview datasource methods
     func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sessions.count
    }
    
     func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("sessioncell", forIndexPath: indexPath) as! LocalSessionViewCell
        let currSession = sessions[indexPath.item]
        
        cell.userInteractionEnabled = true
        cell.sessionName.text = currSession.name
        cell.currentRating.text = currSession.avgRatingAsNonOptionalString()
        cell.salesforceId = currSession.salesforceId
      
        //set button tags to the current item in the arrow to help us get it when the button is pressed later.
        cell.continueRatingButton?.addTarget(self, action: "continueRatingTapped:", forControlEvents: .TouchUpInside)
        cell.continueRatingButton?.tag = indexPath.item
        
        cell.syncToCloudButton?.addTarget(self, action: "syncToCloudTapped:", forControlEvents: .TouchUpInside)
        cell.syncToCloudButton?.tag = indexPath.item
        
        
        
        return cell
    }
    
    //MARK handle button clicks
    
     func continueRatingTapped(sender: UIButton) {
        
        selectedSession = sessions[sender.tag]
        self.performSegueWithIdentifier("ratesession", sender: self)
        
    }
    
    func syncToCloud(sender: UIButton) {
        
    }
}


