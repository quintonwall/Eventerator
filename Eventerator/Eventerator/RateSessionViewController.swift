//
//  RateSessionViewController.swift
//  Eventerator
//
//  Created by Quinton Wall on 10/5/15.
//  Copyright © 2015 Quinton Wall. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class RateSessionViewController: UIViewController {

    var currentSession : Session?
    
    @IBOutlet weak var sessionName: UILabel!
    
  
    @IBOutlet weak var ratingDescriptor: UILabel!

   
   
    @IBOutlet weak var rating1: SpringButton!
    @IBOutlet weak var rating2: SpringButton!
    @IBOutlet weak var rating3: SpringButton!
    @IBOutlet weak var rating4: SpringButton!
    @IBOutlet weak var rating5: SpringButton!
   
    
    @IBOutlet weak var avgRating: UILabel!
    @IBOutlet weak var ratingSpringView: SpringView!
    
    
    var player : AVAudioPlayer! = nil
    var alertSound : NSURL?
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        if  !SFAuthenticationManager.sharedManager().haveValidSession {
            self.performSegueWithIdentifier("login", sender: self)
        }

        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        currentSession!.dump()
        sessionName.text = currentSession?.name
        avgRating.text = currentSession?.avgRatingAsNonOptionalString()
        rating1.tag = 1
        rating2.tag = 2
        rating3.tag = 3
        rating4.tag = 4
        rating5.tag = 5
        
        alertSound = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("button-09", ofType: "wav")!)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func ratingTapped(sender: AnyObject) {
        print("SENDER \(sender.tag)")
        let tag: Int = sender.tag
        do {
            try player = AVAudioPlayer(contentsOfURL: alertSound!, fileTypeHint: "wav")
            player.prepareToPlay()
            player.play()
            let btn: SpringButton = sender as! SpringButton
            btn.animation = "squeeze"  //need to reset the animation style here otherwise, the animation only occurs once
            btn.animate()
            currentSession?.addRating(tag)
            currentSession?.dump()
            avgRating.text = currentSession?.avgRatingAsNonOptionalString() 
          
            ratingSpringView.animation = "squeezeUp"
            ratingSpringView.animate()
            
            
        }
        catch _ {
            print("FAILED TO PLAY AUDIO")
        }
       
    }
    
    
    func updateRating(rating: Int) {
     
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
