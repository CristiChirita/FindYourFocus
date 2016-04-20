//
//  View2.swift
//  Tour
//
//  Created by Keshav Aggarwal on 01/03/16.
//  Copyright © 2016 University College London. All rights reserved.
//

import UIKit

class View2: UIViewController {

    @IBOutlet weak var label2: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        label2.text = "Our science of attention uses all the latest science and technology to understand when you can achieve a focused attention state."
        
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
