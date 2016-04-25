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
    //var ref = Firebase(url: "https://testyourfocus.firebaseio.com")

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "backgroundImage.png")!)
        
        self.email.delegate = self
        self.password.delegate = self
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillShow:"), name:UIKeyboardWillShowNotification, object: nil);
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name:UIKeyboardWillHideNotification, object: nil);
    }
    
    func keyboardWillShow(sender: NSNotification) {
        self.view.frame.origin.y = -75
    }
    
    func keyboardWillHide(sender: NSNotification) {
        self.view.frame.origin.y = 0
    }
    
    func alertMessage(title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
        
        self.presentViewController(alert, animated: true, completion: nil)
        
    }

    @IBAction func signUp(sender: UIButton) {
        
        if email.text == "" || password.text == "" {
            
            alertMessage("Error in Form", message: "Please enter a valid email and password.")
            
        } else {
            
            if(password.text?.characters.count >= 6) {
                
                //self.performSegueWithIdentifier("SignUpToGender", sender: sender)
                ref.createUser(email.text, password: password.text, withValueCompletionBlock: {
                    error, result in
                    if error != nil {
                        self.alertMessage("Error in Form", message: "Please enter a valid email and password.")            }
                    else { let uid = result["uid"] as? String
                        print ("User ID = \(uid!)")
                        //let auth = Authentification()
                        UID = uid!
                        userData.setObject(uid!, forKey: Keys.UID)
                        //userData.synchronize();
                        EMAIL = self.email.text!
                        userData.setObject(self.email.text!, forKey: Keys.EMAIL)
                        //userData.synchronize();
                        PASSWORD = self.password.text!
                        userData.setObject(self.password.text!, forKey: Keys.PASSWORD)
                        //userData.synchronize();
                        SAMPLENO = 1
                        userData.setInteger(1, forKey: Keys.SAMPLENO)
                        userData.synchronize();
                        ref.authUser(self.email.text, password: self.password.text,
                            withCompletionBlock: { error, authData in
                                if error != nil {
                                    // There was an error logging in to this account
                                } else {
                                    // We are now logged in
                                    let newUser = [
                                        "provider": authData.provider,
                                        //"dispayName": self.email.text
                                    ]
                                    ref.childByAppendingPath("Users").childByAppendingPath(authData.uid).childByAppendingPath("Data").setValue(newUser)
                                }
                        })
                        self.performSegueWithIdentifier("SignUpToGender", sender: sender)
                        
                    }
                })
            } else {
                
                alertMessage("Error in Form", message: "Password should be atleast 6 characters long.")
            }
            
        }
    }
    
    
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
