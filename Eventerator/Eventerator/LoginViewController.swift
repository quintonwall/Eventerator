//
//  LoginViewController.swift
//  Eventerator
//
//  Created by Quinton Wall on 10/6/15.
//  Copyright © 2015 Quinton Wall. All rights reserved.
//

import UIKit



class LoginViewController: UIViewController,SFAuthenticationManagerDelegate {

    
    @IBOutlet weak var loginButton: UIButton!
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        //make window 30% the size of the app to give us a little popup effect.
        self.view.bounds = CGRectMake(0, 0, UIScreen.mainScreen().bounds.width * 0.30, UIScreen.mainScreen().bounds.height * 0.30)
        
          SFAuthenticationManager.sharedManager().addDelegate(self)
        
        //button formatting
        loginButton.backgroundColor = UIColor.clearColor()
        loginButton.layer.cornerRadius = 5
        loginButton.layer.borderWidth = 1
        loginButton.layer.borderColor = UIColor.whiteColor().CGColor
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
    }
    
    @IBAction func loginTapped(sender: AnyObject) {
        print("login button tapped")
        SalesforceSDKManager.sharedManager().launch()
    }
    
    func authManagerDidFinish(manager: SFAuthenticationManager!, info: SFOAuthInfo!) {
        
        if  SFAuthenticationManager.sharedManager().haveValidSession {
            //call the segue with the name you give it in the storyboard editor
            self.performSegueWithIdentifier("loggedin", sender: nil)
        }
    }
}
