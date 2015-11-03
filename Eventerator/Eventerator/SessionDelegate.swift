//
//  SessionDelegate.swift
//  Eventerator
//
// Handle all the logic to interact with session object in salesforce
//
//  Created by Quinton Wall on 11/2/15.
//  Copyright © 2015 Quinton Wall. All rights reserved.
//

import Foundation


class SessionDelegate {
    
  
    
    static func searchForSession(speakername: String, sessionname: String) -> AnyObject! {
       
        //var sessions = [Session]()
        var resp: String?
        
        var request = SFRestAPI.sharedInstance().requestForQuery("select Average_Ratings__c, Event__r.Event_Name__c, Id, Name, Num_Ratings__c, Session_Name__c, SystemModstamp, Total_Ratings__c from Session__c WHERE Session_Name__c like \'%\(sessionname)%\' ORDER BY Session_Name__c")
        
        SFRestAPI.sharedInstance().sendRESTRequest(request, failBlock: { error in
            print("Problem getting sessions \(error)")
            resp = error.description
            
            }) { response in  //success
               //map session data here.
                print("SUCCESS: \(response)")
                resp = response.description
        }
        return resp
    }
}