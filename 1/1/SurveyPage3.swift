//
//  SurveyPage3.swift
//  1
//
//  Created by Keshav Aggarwal on 20/03/16.
//  Copyright © 2016 University College London. All rights reserved.
//

import UIKit
import Firebase

class SurveyPage3: UIViewController {

    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var begin: UIButton!
    @IBOutlet weak var menuButton: UIBarButtonItem!
    let ref = Firebase (url: "https://testyourfocus.firebaseio.com")
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let sampleRef = ref.childByAppendingPath("Users").childByAppendingPath(userData.stringForKey(Keys.UID)).childByAppendingPath("Samples").childByAppendingPath(userData.stringForKey(Keys.SAMPLENO)).childByAppendingPath("SliderValues")
        let value = slider.value
        sampleRef.updateChildValues(["Focus level" : "\(value)"])
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "app background.png")!)
        
        // Do any additional setup after loading the view.
        
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
