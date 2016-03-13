//
//  Consent To Participate.swift
//  1
//
//  Created by Keshav Aggarwal on 05/03/16.
//  Copyright © 2016 University College London. All rights reserved.
//

import UIKit

class Consent_To_Participate: UIViewController {
    
    
    
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label3: UILabel!
    @IBOutlet weak var label4: UILabel!
    @IBOutlet weak var label5: UILabel!
    @IBOutlet weak var label6: UILabel!
    @IBOutlet weak var label7: UILabel!
    @IBOutlet weak var label8: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        label1.text = "I have read all the information provided in the last two screens"
        
        label2.text = "participation is voluntary and I can stop answering at any given time."
        
        label3.text = "I can delete my account in the Settings menu."
        
        label4.text = "I will not respond to this app while driving or taking part in any activity that puts me at risk."
        
        label5.text = "my data will be stored on secure servers in line with data protection laws."
        
        label6.text = "there are no costs associated with participation in this app but accept that it is my responsibility that I remain within the limits of my mobile data plan."
        
        label7.text = "all the information that I provide will remain confidential."
        
        label8.text = "accumulated data (combined from groups of users) may be published or presented at scientific meetings (my personal information will never be included in this and I will never be identifiable from the results presented)."
        
    }

    @IBAction func click(sender: UIButton) {
        
        if(sender.currentImage! != UIImage(named:"Checkbox Full.png")) {
            
            sender.setImage(UIImage(named: "Checkbox Full.png"), forState: UIControlState.Normal)
            
        } else {
            
            sender.setImage(UIImage(named: "Checkbox Empty.png"), forState: UIControlState.Normal)
            
        }
        
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

}
