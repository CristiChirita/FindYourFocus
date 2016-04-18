//
//  View4.swift
//  Tour
//
//  Created by Keshav Aggarwal on 01/03/16.
//  Copyright © 2016 University College London. All rights reserved.
//

import UIKit

class View4: UIViewController {

    @IBOutlet weak var label4: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        label4.text = "Click the Home bar button above to start tracking your focus!"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
