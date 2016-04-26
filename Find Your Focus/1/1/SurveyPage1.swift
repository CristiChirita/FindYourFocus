//
//  SurveyPage1.swift
//  1
//
//  Created by Keshav Aggarwal on 13/03/16.
//  Copyright © 2016 University College London. All rights reserved.
//

import UIKit
import Firebase


class SurveyPage1: UIViewController {

 
    @IBOutlet weak var time: UITextField!
    
    @IBOutlet weak var other: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "backgroundImage.png")!)

        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillShow:"), name:UIKeyboardWillShowNotification, object: nil);
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name:UIKeyboardWillHideNotification, object: nil);
        
        
    }
    
    
    @IBAction func listOpened(sender: AnyObject) {
       openedList=true
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let sampleRef = ref.childByAppendingPath("Users").childByAppendingPath(userData.stringForKey(Keys.UID)).childByAppendingPath("Samples").childByAppendingPath(userData.stringForKey(Keys.SAMPLENO)).childByAppendingPath("LastAction")
        let pastActionTimer = ["Time" : "\(time.text!) minutes",
                               "Other" : "\(other.text)"]
        sampleRef.updateChildValues(pastActionTimer)
        if (openedList==false)
        {
            let activities = userData.objectForKey(Keys.ACTIVITIES) as! [String]
            for _ in activities
            {
                posDistracted.append(0)
            }
        }
    }
    
    func keyboardWillShow(sender: NSNotification) {
        self.view.frame.origin.y = -130
    }
    
    func keyboardWillHide(sender: NSNotification) {
        self.view.frame.origin.y = 0
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
