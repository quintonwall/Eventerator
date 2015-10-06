//
//  LoginViewController.swift
//  Eventerator
//
//  Created by Quinton Wall on 10/6/15.
//  Copyright © 2015 Quinton Wall. All rights reserved.
//

import UIKit
import OAuthSwift
import Alamofire

class LoginViewController: UIViewController {

    
    @IBOutlet weak var loginButton: UIButton!
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.view.bounds = CGRectMake(0, 0, UIScreen.mainScreen().bounds.width * 0.30, UIScreen.mainScreen().bounds.height * 0.30)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    
    @IBAction func loginTapped(sender: AnyObject) {
        doOAuthSalesforce()
    }
    
    func doOAuthSalesforce(){
        let oauthswift = OAuth2Swift(
            consumerKey:    Constants.SALESFORCE["consumerKey"]!,
            consumerSecret: Constants.SALESFORCE["consumerSecret"]!,
            authorizeUrl:   "https://login.salesforce.com/services/oauth2/authorize",
            accessTokenUrl: "https://login.salesforce.com/services/oauth2/token",
            responseType:   "code"
        )
        let state: String = generateStateWithLength(20) as String
        oauthswift.authorizeWithCallbackURL( NSURL(string: "oauth-swift://oauth-callback/salesforce")!, scope: "full", state: state, success: {
            credential, response, parameters in
             let defaults = NSUserDefaults.standardUserDefaults()
             defaults.setBool(true, forKey: Constants.LOGGEDIN)
             defaults.setValue(credential.oauth_token, forKey: Constants.AUTH_TOKEN)
            
            var headers = Alamofire.Manager.sharedInstance.session.configuration.HTTPAdditionalHeaders ?? [:]
            headers["Authorization"] = credential.oauth_token
            
            let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
            configuration.HTTPAdditionalHeaders = headers
           
            self.dismissViewControllerAnimated(true, completion: nil)
            
            }, failure: {(error:NSError!) -> Void in
                print(error.localizedDescription)
        })
    }
}
