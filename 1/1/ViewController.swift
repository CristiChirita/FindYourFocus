
//  ViewController.swift
//  1
//
//  Created by Keshav Aggarwal on 01/03/16.
//  Copyright © 2016 University College London. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        if let image = UIImage(named: "backgroundImage.png") {
            self.view.backgroundColor = UIColor(patternImage: image)
        } else {
            print("There was no such image as background.jpg")
        }
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "backgroundImage.png")!)
    }
    

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

