//
//  Notification Information.swift
//  1
//
//  Created by Keshav Aggarwal on 05/03/16.
//  Copyright © 2016 University College London. All rights reserved.
//

import UIKit

class Notification_Information: UIViewController {

    @IBOutlet weak var pageView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label3: UILabel!
    @IBOutlet weak var label4: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        pageView.backgroundColor = UIColor(patternImage: UIImage(named: "backgroundImage.png")!)
        
        scrollView.contentSize = CGSizeMake(self.view.frame.width, 600)
        
        label1.text = "This app records your attention focus and state of mind and how these relate to daily activities."
        
        label2.text = "Once signed up you will receive notifications during your waking hours (except for the first and last hour) asking you about your current activity, focus and state."
        
        label3.text = "The goal is to help people find their optimal state to achieve their peak focus."
        
        label4.text = " Any questions? Contact info@brainfocus.co.uk"
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
