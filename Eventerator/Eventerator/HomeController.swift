//
//  HomeController.swift
//  Eventerator
//
//  Created by Quinton Wall on 11/2/15.
//  Copyright © 2015 Quinton Wall. All rights reserved.
//

import UIKit

class HomeController: UIViewController {
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
      
        if  !SFAuthenticationManager.sharedManager().haveValidSession {
            self.performSegueWithIdentifier("login", sender: self)
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }

}
