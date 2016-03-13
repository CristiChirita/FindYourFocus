//
//  HP.swift
//  1
//
//  Created by Keshav Aggarwal on 07/03/16.
//  Copyright © 2016 University College London. All rights reserved.
//

import UIKit

class HP: UIViewController {

    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }

    }
    
}
