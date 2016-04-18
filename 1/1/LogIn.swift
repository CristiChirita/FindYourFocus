//
//  LogIn.swift
//  1
//
//  Created by Keshav Aggarwal on 10/03/16.
//  Copyright © 2016 University College London. All rights reserved.
//

import UIKit

class LogIn: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var emailIcon: UIButton!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var passwordIcon: UIButton!
    @IBOutlet weak var logIn: UIButton!
    @IBOutlet weak var logInDidntWork: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "app background.png")!)
        
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
    
    @IBAction func emailEditEnd(sender: UITextField) {
        if email.text == "" {
            emailIcon.setImage(UIImage(named: "message.png"), forState: UIControlState.Normal)
        }
    }
    
    @IBAction func passwordEditStart(sender: AnyObject) {
        passwordIcon.setImage(UIImage(named: "key_active.png"), forState: UIControlState.Normal)
    }
    
    @IBAction func passwordEditEnd(sender: UITextField) {
        if password.text == "" {
            passwordIcon.setImage(UIImage(named: "key.png"), forState: UIControlState.Normal)
        }
    }
    
    @IBAction func logInButtonPressed(sender: AnyObject) {
        
        
        
        if email.text == "" || password.text == "" {
            
            let animation = CABasicAnimation(keyPath: "position")
            animation.duration = 0.07
            animation.repeatCount = 2
            animation.autoreverses = true
            animation.fromValue = NSValue(CGPoint: CGPointMake(logIn.center.x - 10, logIn.center.y))
            animation.toValue = NSValue(CGPoint: CGPointMake(logIn.center.x + 10, logIn.center.y))
            logIn.layer.addAnimation(animation, forKey: "position")
            
            logInDidntWork.hidden = false
    
        }  else {
            logInDidntWork.hidden = true
           self.performSegueWithIdentifier("LogInToHome", sender: sender)
        }

        
    }

}
