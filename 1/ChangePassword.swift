//
//  ChangePassword.swift
//  1
//
//  Created by Keshav Aggarwal on 08/03/16.
//  Copyright © 2016 University College London. All rights reserved.
//

import UIKit

class ChangePassword: UIViewController {

    @IBOutlet weak var oldPassword: UITextField!
    @IBOutlet weak var newPassword: UITextField!
    @IBOutlet weak var retypeNewPassword: UITextField!
    
    
    func alertMessage(title: String, message: String) {
        
        // create the alert
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        
        // add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: .Destructive, handler: nil))
        
        // show the alert
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func donePressed(sender: UIBarButtonItem) {
        
        if oldPassword.text == newPassword.text {
            
            alertMessage("Error In Form", message: "New Password cannot be same as the old password.")
            
        } else {
            
            if newPassword.text == retypeNewPassword.text {
            
                // create the alert
                let alert = UIAlertController(title: "Password Change", message: "Password Successfully Changed", preferredStyle: UIAlertControllerStyle.Alert)
                
                // add an action (button)
                
                alert.addAction(UIAlertAction(title: "Continue", style: .Destructive, handler: { (action)  -> Void in
                    
                    self.performSegueWithIdentifier("PasswordChangeSuccessful", sender: sender)
                    
                }))
                
                // show the alert
                self.presentViewController(alert, animated: true, completion: nil)
            
            } else {
            
                alertMessage("Error In Form", message: "Retype New Password and New Password do not match.")
            
            }
            
        }
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
