//
//  hasAnythingDivertedYourAttention.swift
//  Survey
//
//  Created by Keshav Aggarwal on 03/03/16.
//  Copyright © 2016 University College London. All rights reserved.
//

import UIKit
import Firebase

class hasAnythingDivertedYourAttention: UIViewController {
    

    @IBOutlet weak var yesRadio: UIButton!

    @IBOutlet weak var noRadio: UIButton!
    
    @IBOutlet weak var duration: UILabel!

    @IBOutlet weak var slide: UISlider!
    
    @IBOutlet weak var minuteOrLess: UILabel!
    
    @IBOutlet weak var minuteOrMore: UILabel!
    
    @IBOutlet weak var next: UIBarButtonItem!
    
    //let ref = Firebase(url: "https://testyourfocus.firebaseio.com")

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "backgroundImage.png")!)
        
        duration.text = "If the distraction was longer than 1 minute, please estimate how long your attention been diverted for."
    }
    
    @IBAction func yesClicked(sender: UIButton) {
        
        next.enabled = true
        
        yesRadio.setImage(UIImage(named: "radio_active.png"), forState: UIControlState.Normal)
        noRadio.setImage(UIImage(named: "radio_inactive.png"), forState: UIControlState.Normal)
        
        duration.hidden = false
        slide.hidden = false
        minuteOrLess.hidden = false
        minuteOrMore.hidden = false
    }
    
    
    
    @IBAction func noClicked(sender: UIButton) {
        
        next.enabled = true
        
        noRadio.setImage(UIImage(named: "radio_active.png"), forState: UIControlState.Normal)
        
        yesRadio.setImage(UIImage(named: "radio_inactive.png"), forState: UIControlState.Normal)
        
        duration.hidden = true
        slide.hidden = true
        minuteOrLess.hidden = true
        minuteOrMore.hidden = true
    }
    
    /*@IBAction func nextPressed(sender: UIBarButtonItem) {
        if(duration.hidden == false) {
            
            performSegueWithIdentifier("ifYes", sender: self)
            
        } else {
            
            performSegueWithIdentifier("ifNo", sender: self)
            
        }
    } */
    
    @IBAction func nextPressed(sender: UIBarButtonItem) {
        var durationTime : [String : String]
        let sampleRef = ref.childByAppendingPath("Users").childByAppendingPath(userData.stringForKey(Keys.UID)).childByAppendingPath("Samples").childByAppendingPath(userData.stringForKey(Keys.SAMPLENO)).childByAppendingPath("AttentionDiverted")
        if (duration.hidden == false) {
            durationTime = ["Diverted" : "\(slide.value) minutes"]
            var distractionCount = userData.objectForKey(Keys.DISTRACTEDCOUNT) as! [Int]
            for var i=0;i<distractionCount.count;i++
            {
                distractionCount[i] += posDistracted[i]
            }
            userData.setObject(distractionCount, forKey: Keys.DISTRACTEDCOUNT)
            backupRef.childByAppendingPath(userData.stringForKey(Keys.UID)).childByAppendingPath("DistractedCount").setValue(distractionCount)
            sampleRef.updateChildValues(durationTime)
            performSegueWithIdentifier("ifYes", sender: self)
        }
        else {
            durationTime = ["Diverted" : "No"]
            sampleRef.setValue(durationTime)
            performSegueWithIdentifier("ifNo", sender: self)
            
        }
        
    }

}
