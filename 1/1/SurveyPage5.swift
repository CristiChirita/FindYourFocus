//
//  SurveyPage5.swift
//  1
//
//  Created by Keshav Aggarwal on 20/03/16.
//  Copyright © 2016 University College London. All rights reserved.
//

import UIKit
import Firebase

class SurveyPage5: UIViewController {
    
    let ref = Firebase (url: "https://testyourfocus.firebaseio.com")
    
    @IBOutlet weak var slider: UISlider!

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let sampleRef = ref.childByAppendingPath("Users").childByAppendingPath(userData.stringForKey(Keys.UID)).childByAppendingPath("Samples").childByAppendingPath(userData.stringForKey(Keys.SAMPLENO)).childByAppendingPath("SliderValues")
        let value = slider.value
        sampleRef.updateChildValues(["Happiness level" : "\(value)"])
        let now = NSDate();
        ref.childByAppendingPath("Users").childByAppendingPath(userData.stringForKey(Keys.UID)).childByAppendingPath("Samples").childByAppendingPath(userData.stringForKey(Keys.SAMPLENO)).updateChildValues(["End Time" : "\(now)"])
        //SAMPLENO = SAMPLENO! + 1
        let newSampleCount = userData.integerForKey(Keys.SAMPLENO) + 1
        userData.setInteger(newSampleCount, forKey: Keys.SAMPLENO);
        
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "app background.png")!)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
