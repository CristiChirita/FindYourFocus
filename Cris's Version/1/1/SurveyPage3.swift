//
//  SurveyPage3.swift
//  1
//
//  Created by Keshav Aggarwal on 20/03/16.
//  Copyright © 2016 University College London. All rights reserved.
//

import UIKit
import Firebase

var focus : Int?

class SurveyPage3: UIViewController {

    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var begin: UIButton!
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var focused: UILabel!
    @IBOutlet weak var unfocused: UILabel!
    @IBOutlet weak var maxFocus: UILabel!
    @IBOutlet weak var minFocus: UILabel!
    @IBOutlet weak var mainText: UILabel!
    //let ref = Firebase (url: "https://testyourfocus.firebaseio.com")
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        backupRef.childByAppendingPath(userData.stringForKey(Keys.UID)).observeSingleEventOfType(.Value, withBlock:
            {
                snapshot in
                let sampleNo = snapshot.value[Keys.SAMPLENO] as! Int
                userData.setInteger(sampleNo, forKey: Keys.SAMPLENO)
                userData.synchronize()
        })
        let sampleRef = ref.childByAppendingPath("Users").childByAppendingPath(userData.stringForKey(Keys.UID)).childByAppendingPath("Samples").childByAppendingPath(userData.stringForKey(Keys.SAMPLENO)).childByAppendingPath("SliderValues")
        let value = slider.value
        focus = Int(value);
        var totalFocus = userData.integerForKey(Keys.TOTALFOCUS)
        totalFocus += focus!
        userData.setInteger(totalFocus, forKey: Keys.TOTALFOCUS)
        backupRef.childByAppendingPath(userData.stringForKey(Keys.UID)).updateChildValues(["TotalFocus" : totalFocus])
        sampleRef.updateChildValues(["Focus level" : "\(value)"])
        let now = NSDate();
        ref.childByAppendingPath("Users").childByAppendingPath(userData.stringForKey(Keys.UID)).childByAppendingPath("Samples").childByAppendingPath(userData.stringForKey(Keys.SAMPLENO)).updateChildValues(["Start Time" : "\(now)"])
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "backgroundImage.png")!)
        
        // Do any additional setup after loading the view.
        
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        if (notificationfired == false)
        {
            slider.hidden=true
            begin.hidden=true
            maxFocus.hidden=true
            minFocus.hidden=true
            focused.hidden=true
            unfocused.hidden=true
            mainText.text = "Sorry, no samples available. Please try again later."
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
