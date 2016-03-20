//
//  Log In.swift
//  1
//
//  Created by Keshav Aggarwal on 06/03/16.
//  Copyright © 2016 University College London. All rights reserved.
//

import UIKit

class Log_In: UIViewController {

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func logIn(sender: UIBarButtonItem) {
        
        if email.text == "" || password.text == "" {
            
            
            
            let alert = UIAlertController(title: "Error in Form ", message: "Pleas enter a valid email and password.", preferredStyle: UIAlertControllerStyle.Alert)
            //alert.addAction(UIAlertAction(title: "OK", style: .Destructive, handler: nil))
            alert.addAction(UIAlertAction(title: "OK", style: .Destructive, handler: { (action)  -> Void in
                
                self.dismissViewControllerAnimated(true, completion: nil)
                
            }))
            self.presentViewController(alert, animated: true, completion: nil)
            
        }  else {
            
            self.performSegueWithIdentifier("LogInToHome", sender: sender)
            
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
