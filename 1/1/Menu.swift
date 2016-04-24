//
//  Menu.swift
//  1
//
//  Created by Keshav Aggarwal on 24/04/16.
//  Copyright © 2016 University College London. All rights reserved.
//

import UIKit

class Menu: UITableViewController {

    @IBOutlet weak var signOut: UITableViewCell!
    var tapRecognizer = UITapGestureRecognizer()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        tapRecognizer.addTarget(self, action: "signingOut:")
        signOut.addGestureRecognizer(tapRecognizer)
    }
    
    func signingOut(sender: UITapGestureRecognizer) {
        self.performSegueWithIdentifier("signOut", sender: sender)
    }
}
