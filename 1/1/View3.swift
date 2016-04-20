//
//  View3.swift
//  Tour
//
//  Created by Keshav Aggarwal on 01/03/16.
//  Copyright © 2016 University College London. All rights reserved.
//

import UIKit

class View3: UIViewController {

    @IBOutlet weak var label3: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        label3.text = "You’ll receive a few notifications during the day asking you about your attention state, the nature of your activity (you can pick from a list) and about how happy you feel. This will help us generate a picture of your attention habits and state."
        
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
