//
//  ChartsLicense.swift
//  1
//
//  Created by Keshav Aggarwal on 15/04/16.
//  Copyright © 2016 University College London. All rights reserved.
//

import UIKit

class ChartsLicense: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.contentSize = CGSizeMake(self.view.frame.width, 600)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
