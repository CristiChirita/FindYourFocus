//
//  Gender.swift
//  1
//
//  Created by Keshav Aggarwal on 06/03/16.
//  Copyright © 2016 University College London. All rights reserved.
//

import UIKit

class Gender: UIViewController {

    @IBOutlet weak var maleRadio: UIButton!
    @IBOutlet weak var femaleRadio: UIButton!
    @IBOutlet weak var next: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func maleClicked(sender: UIButton) {
        
        maleRadio.setImage(UIImage(named: "radio_active.png"), forState: UIControlState.Normal)
        
        femaleRadio.setImage(UIImage(named: "radio_inactive.png"), forState: UIControlState.Normal)
        
        next.enabled = true
        
    }
    
    
    @IBAction func femaleClicked(sender: UIButton) {
        
        femaleRadio.setImage(UIImage(named: "radio_active.png"), forState: UIControlState.Normal)
        
        maleRadio.setImage(UIImage(named: "radio_inactive.png"), forState: UIControlState.Normal)
        
        next.enabled = true
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
