//
//  hasAnythingDivertedYourAttention.swift
//  Survey
//
//  Created by Keshav Aggarwal on 03/03/16.
//  Copyright © 2016 University College London. All rights reserved.
//

import UIKit

class hasAnythingDivertedYourAttention: UIViewController {
    
    @IBOutlet weak var yesRadio: UIButton!
    
    
    @IBOutlet weak var noRadio: UIButton!
    
    
    @IBOutlet weak var duration: UILabel!
    
    @IBOutlet weak var slide: UISlider!
    
    @IBOutlet weak var minuteOrLess: UILabel!
    
    @IBOutlet weak var minuteOrMore: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        duration.text = "If the distraction was longer than 1 minute, please estimate how long your attention been diverted for."
    }
    
    @IBAction func yesClicked(sender: UIButton) {
        
        yesRadio.setImage(UIImage(named: "radio-button_on.png"), forState: UIControlState.Normal)
        
        noRadio.setImage(UIImage(named: "radio-button_off.png"), forState: UIControlState.Normal)
        
        duration.hidden = false
        slide.hidden = false
        minuteOrLess.hidden = false
        minuteOrMore.hidden = false
        
    }
    
    
    @IBAction func noClicked(sender: UIButton) {
        
        noRadio.setImage(UIImage(named: "radio-button_on.png"), forState: UIControlState.Normal)
        
        yesRadio.setImage(UIImage(named: "radio-button_off.png"), forState: UIControlState.Normal)
        
        duration.hidden = true
        slide.hidden = true
        minuteOrLess.hidden = true
        minuteOrMore.hidden = true
        
    }
    
    @IBAction func next(sender: UIBarButtonItem) {
        
        if(duration.hidden == false) {

            performSegueWithIdentifier("ifYes", sender: self)
        
        } else {
            
            performSegueWithIdentifier("ifNo", sender: self)
            
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
