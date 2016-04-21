//
//  ChangePassword.swift
//  1
//
//  Created by Keshav Aggarwal on 08/03/16.
//  Copyright © 2016 University College London. All rights reserved.
//

import UIKit
import Firebase

class ChangePassword: UIViewController {

    @IBOutlet weak var oldPassword: UITextField!
    @IBOutlet weak var newPassword: UITextField!
    @IBOutlet weak var retypeNewPassword: UITextField!
    let ref = Firebase (url: "https://testyourfocus.firebaseio.com")
    
    
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
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "app background.png")!)

        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillShow:"), name:UIKeyboardWillShowNotification, object: nil);
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name:UIKeyboardWillHideNotification, object: nil);
        
    }
    
    func keyboardWillShow(sender: NSNotification) {
        self.view.frame.origin.y = -95
    }
    
    func keyboardWillHide(sender: NSNotification) {
        self.view.frame.origin.y = 0
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }

    
    /*@IBAction func donePressed(sender: UIBarButtonItem) {
        
        if oldPassword.text == newPassword.text {
            
            alertMessage("Error In Form", message: "New Password cannot be same as the old password.")
            
        } else {
            
            if newPassword.text == retypeNewPassword.text {
            
                // create the alert
                let alert = UIAlertController(title: "Password Change", message: "Password Successfully Changed", preferredStyle: UIAlertControllerStyle.Alert)
                
                // add an action (button)
                
                alert.addAction(UIAlertAction(title: "Continue", style: .Destructive, handler: { (action)  -> Void in
                    
                    self.ref.changePasswordForUser(EMAIL, fromOld: self.oldPassword.text, toNew: self.newPassword.text, withCompletionBlock:
                        
                        {
                            error in
                            
                            if error != nil {}
                            else {
                                userData.setObject(self.newPassword.text, forKey: Keys.PASSWORD);
                                userData.synchronize();
                            }
                    })
                    
                    
                }))
                
                // show the alert
                //self.performSegueWithIdentifier("PasswordChangeSuccessful", sender: sender)
                self.presentViewController(alert, animated: true, completion: nil)
            
            } else {
            
                alertMessage("Error In Form", message: "Retype New Password and New Password do not match.")
            
            }
            
        }
        
    } */
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if oldPassword.text == newPassword.text {
            
            alertMessage("Error In Form", message: "New Password cannot be same as the old password.")
            
        } else {
            
            if newPassword.text == retypeNewPassword.text && oldPassword.text! == userData.stringForKey(Keys.PASSWORD)! {
                
                // create the alert
                let alert = UIAlertController(title: "Password Change", message: "Password Successfully Changed", preferredStyle: UIAlertControllerStyle.Alert)
                
                // add an action (button)
                
                alert.addAction(UIAlertAction(title: "Continue", style: .Destructive, handler: { (action)  -> Void in
                    print(self.oldPassword.text!)
                    print(self.newPassword.text!)
                    print(userData.stringForKey(Keys.EMAIL)!)
                    self.ref.changePasswordForUser(userData.stringForKey(Keys.EMAIL)!, fromOld: self.oldPassword.text!, toNew: self.newPassword.text!, withCompletionBlock:
                        
                        {
                            error in
                            
                            if error != nil {
                            print("Nope")
                            print(error)
                            }
                            else {
                                userData.setObject(self.newPassword.text!, forKey: Keys.PASSWORD);
                                userData.synchronize();
                                
                            }
                    })
                    
                    
                }))
                
                // show the alert
                self.presentViewController(alert, animated: true, completion: nil)
                //self.performSegueWithIdentifier("PasswordChangeSuccessful", sender: sender)
                
                
            } else {
                
                alertMessage("Error In Form", message: "Passwords do not match")
                
            }
            
        }
        

    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
