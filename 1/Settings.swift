//
//  Settings.swift
//  1
//
//  Created by Keshav Aggarwal on 08/03/16.
//  Copyright © 2016 University College London. All rights reserved.
//

import UIKit

class Settings: UIViewController {

    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    }

    
    @IBAction func deleteAccountPressed(sender: UIButton) {
        
        // create the alert
        let alert = UIAlertController(title: "Delete Account", message: "Are you sure you want to delete your account?", preferredStyle: UIAlertControllerStyle.Alert)
        
        // add the actions (buttons)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .Destructive, handler: nil))
        
        alert.addAction(UIAlertAction(title: "Continue", style: .Destructive, handler: { (action)  -> Void in
            
            self.performSegueWithIdentifier("accountDeleted", sender: sender)
            
        }))
        
        
        // show the alert
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
