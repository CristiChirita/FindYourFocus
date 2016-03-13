//
//  Sign Up.swift
//  1
//
//  Created by Keshav Aggarwal on 06/03/16.
//  Copyright © 2016 University College London. All rights reserved.
//

import UIKit
import Firebase

class Sign_Up: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var emailIcon: UIButton!
    @IBOutlet weak var passwordIcon: UIButton!
    var myRootRef = Firebase(url: "https://testyourfocus.firebaseio.com")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.email.delegate = self
        self.password.delegate = self
        
    }
    
    func alertMessage(title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        //alert.addAction(UIAlertAction(title: "OK", style: .Destructive, handler: nil))
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action)  -> Void in
            
            self.dismissViewControllerAnimated(true, completion: nil)
            
        }))
        self.presentViewController(alert, animated: true, completion: nil)
        
    }

    @IBAction func signUp(sender: UIButton) {
        if email.text == "" || password.text == "" {
            
            alertMessage("Error in Form", message: "Please enter a valid email and password.")
            
        } else {
            
            if(password.text?.characters.count >= 6) {
                
                self.performSegueWithIdentifier("SignUpToGender", sender: sender)
                
            } else {
                
                alertMessage("Error in Form", message: "Password should be atleast 6 characters long.")
            }
            
        }
        myRootRef.createUser(email.text, password: password.text, withValueCompletionBlock: {
          error, result in
            if error != nil {
            alertMessage("Error in Form", message: "Please enter a valid email and password.")            }
            else { let uid = result["uid"] as? String}
        })
        myRootRef.authUser(email, password: password,
            withCompletionBlock: { error, authData in
                if error != nil {
                    // There was an error logging in to this account
                } else {
                    // We are now logged in
                    let newUser = [
                        "provider" = authData.provider,
                        "dispayName" = authData.providerData["displayName"] as? NSString as? String
                    ]
                    myRootRef.childByAppendingPath("Users").childByAppendingPath(authData.uid).childByAppendingPath("Data").setValue(newUser)
                }
        })    }
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }


    @IBAction func emailEditStart(sender: AnyObject) {
        emailIcon.setImage(UIImage(named: "message_active.png"), forState: UIControlState.Normal)
    }
    
    @IBAction func emailEditEnd(sender: AnyObject) {
        if email.text == "" {
            emailIcon.setImage(UIImage(named: "message.png"), forState: UIControlState.Normal)
        }
    }
    
    @IBAction func passwordEditStart(sender: AnyObject) {
        passwordIcon.setImage(UIImage(named: "key_active.png"), forState: UIControlState.Normal)
    }
    
    @IBAction func passwordEditEnd(sender: AnyObject) {
        if password.text == "" {
            passwordIcon.setImage(UIImage(named: "key.png"), forState: UIControlState.Normal)
        }
    }
}
