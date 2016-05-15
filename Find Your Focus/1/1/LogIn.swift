//
//  LogIn.swift
//  1
//
//  Created by Keshav Aggarwal on 10/03/16.
//  Copyright © 2016 University College London. All rights reserved.
//

import UIKit
import Firebase

class LogIn: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var emailIcon: UIButton!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var passwordIcon: UIButton!
    @IBOutlet weak var logIn: UIButton!
    @IBOutlet weak var logInDidntWork: UILabel!
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
            ref.authUser(email.text, password: password.text)
                {
                    error, authData in
                    if error != nil {
                        //UID = authData.uid;
                        let alert = UIAlertController(title: "Error in Form ", message: "Please enter a valid email and password.", preferredStyle: UIAlertControllerStyle.Alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action)  -> Void in
                            
                            //self.dismissViewControllerAnimated(true, completion: nil)
                            
                        }))
                        self.presentViewController(alert, animated: true, completion: nil)
                        
                    }
                    else {//see what data will we need
                        if (authData.uid != userData.stringForKey(Keys.UID))
                        {
                            userData.setObject(authData.uid, forKey: Keys.UID)
                            userData.synchronize()
                            userData.setObject(self.email.text!, forKey: Keys.EMAIL)
                            userData.synchronize()
                            userData.setObject(self.password.text!, forKey: Keys.PASSWORD)
                            userData.synchronize()
                            self.syncronise()
                            UIApplication.sharedApplication().applicationIconBadgeNumber = 0;
                            let now = NSDate()
                            var scheduledNotifications = false
                            let notificationList = UIApplication.sharedApplication().scheduledLocalNotifications!
                            for notification in notificationList
                            {
                                if NSCalendar.currentCalendar().isDate(now, inSameDayAsDate: notification.fireDate!) == false
                                {
                                    scheduledNotifications = true
                                    break
                                }
                            }
                            if (scheduledNotifications == false)
                            {
                                self.scheduleNotifications()
                            }

                            
                        }
                        userData.setBool(true, forKey: Keys.SIGNUPCOMPLETED)
                        userData.synchronize()
                        self.performSegueWithIdentifier("LogInToHome", sender: sender)
                    }
                    
            }
           //self.performSegueWithIdentifier("LogInToHome", sender: sender)
        }

        
    }
    
    func syncronise()
    {
        backupRef.childByAppendingPath(userData.stringForKey(Keys.UID)).observeSingleEventOfType(.Value, withBlock:
            {
                snapshot in
                print(snapshot)
                let age = snapshot.value[Keys.AGE] as! Int
                let sampleNo = snapshot.value[Keys.SAMPLENO] as! Int
                let totalFocus = snapshot.value[Keys.TOTALFOCUS] as! Int
                let wakeUp = snapshot.value[Keys.WAKEUP] as! String
                let sleep = snapshot.value[Keys.SLEEP] as! String
                let error = snapshot.value[Keys.INTERVALERROR] as! Int
                let notifications = snapshot.value[Keys.NOTIFICATIONS] as! Int
                //print(age)
                let dateFormatter = NSDateFormatter()
                dateFormatter.dateFormat = "hh:mm a"
                userData.setInteger(age, forKey: Keys.AGE)
                userData.synchronize()
                userData.setInteger(sampleNo, forKey: Keys.SAMPLENO)
                userData.synchronize()
                userData.setInteger(totalFocus, forKey: Keys.TOTALFOCUS)
                userData.synchronize()
                userData.setObject(dateFormatter.dateFromString(wakeUp), forKey: Keys.WAKEUP)
                userData.synchronize()
                userData.setObject(dateFormatter.dateFromString(sleep), forKey: Keys.SLEEP)
                userData.synchronize()
                userData.setInteger(error, forKey: Keys.INTERVALERROR)
                userData.synchronize()
                userData.setInteger(notifications, forKey: Keys.NOTIFICATIONS)
                userData.synchronize()
                if age >= 18
                {
                    let over18 = ["Resting or sleeping", "Walking", "Watching TV, film, online videos", "News watching", "Listening to music", "Listening to a radio program", "Gaming", "Playing board games", "Childcare", "Playing Sport", "Working", "Studying", "Intimate relations", "Exercising", "Eating", "Reading (books, paper, online)", "Cooking", "Praying or meditating", "Online Chatting", "Email", "Surfing the net", "Engaging with family member", "Engaging with friends", "Shopping, running errands", "Household admin", "Travelling"]
                    userData.setObject(over18, forKey: Keys.ACTIVITIES)
                    userData.synchronize()

                }
                else
                {
                    let below18 = ["Resting or sleeping", "Walking", "Watching TV, film, online videos", "News watching", "Listening to music", "Listening to a radio program or podcast", "Gaming", "Playing board games", "Childcare", "Playing Sport", "Working", "Studying or homework", "Exercising", "Eating", "Reading (books, paper, online)", "Cooking", "Praying or meditating", "Online Chatting", "Email", "Surfing the net", "Engaging with family member", "Engaging with friends", "Shopping, running errands", "Household chores", "Travelling"]
                    userData.setObject(below18, forKey: Keys.ACTIVITIES)
                    userData.synchronize()
                }
                //print(userData.integerForKey(Keys.AGE))
        })
        
        backupRef.childByAppendingPath(userData.stringForKey(Keys.UID)).childByAppendingPath("ActivityCount").observeSingleEventOfType(.Value, withBlock:
            {
                snapshot in
                print(snapshot)
                var activityCount = [Int]()
                var i = 0
                while ((snapshot.value[i] as! Int ) != -1)
                {
                    print(i)
                    //print(snapshot.value[i] as! Int)
                    activityCount.append(snapshot.value[i] as! Int)
                    i++
                }
                userData.setObject(activityCount, forKey: Keys.ACTIVITYCOUNT)
                userData.synchronize()
        })
        backupRef.childByAppendingPath(userData.stringForKey(Keys.UID)).childByAppendingPath("DistractedCount").observeSingleEventOfType(.Value, withBlock:
            {
                snapshot in
                print(snapshot)
                var distractedCount = [Int]()
                var i = 0
                while ((snapshot.value[i] as! Int ) != -1)
                {
                    print(i)
                    //print(snapshot.value[i] as! Int)
                    distractedCount.append(snapshot.value[i] as! Int)
                    i++
                }
                userData.setObject(distractedCount, forKey: Keys.DISTRACTEDCOUNT)
                userData.synchronize()
        })
        backupRef.childByAppendingPath(userData.stringForKey(Keys.UID)).childByAppendingPath("FocusCount").observeSingleEventOfType(.Value, withBlock:
            {
                snapshot in
                print(snapshot)
                var focusCount = [Int]()
                var i = 0
                while ((snapshot.value[i] as! Int ) != -1)
                {
                    print(i)
                    //print(snapshot.value[i] as! Int)
                    focusCount.append(snapshot.value[i] as! Int)
                    i++
                }
                userData.setObject(focusCount, forKey: Keys.ACTIVITYFOCUSLEVEL)
                userData.synchronize()
        })
        backupRef.childByAppendingPath(userData.stringForKey(Keys.UID)).childByAppendingPath("IntervalMiddles").observeSingleEventOfType(.Value, withBlock:
            {
                snapshot in
                print(snapshot)
                let dateFormatter = NSDateFormatter()
                dateFormatter.dateFormat = "hh:mm a"
                let dateString = "00:00 AM"
                var intervalMiddles = [NSDate]()
                var i = 0
                while ((snapshot.value[i] as! String ) != dateString)
                {
                    print(i)
                    //print(snapshot.value[i] as! Int)
                    intervalMiddles.append(dateFormatter.dateFromString(snapshot.value[i] as! String)!)
                    i++
                }
                userData.setObject(intervalMiddles, forKey: Keys.INTERVALMIDDLES)
                userData.synchronize()
        })

        
    }
    
    
    func scheduleNotifications()
    {
        let tomorrow = NSDate().dateByAddingTimeInterval(24*60*60)
        let dayFlags : NSCalendarUnit = [.Day, .Month, .Year]
        let dayComponents = NSCalendar.currentCalendar().components(dayFlags, fromDate: tomorrow)
        let error = userData.integerForKey(Keys.INTERVALERROR) //as! UInt32
        let uError = UInt32(error)
        let intervalMiddles = userData.objectForKey(Keys.INTERVALMIDDLES) as! [NSDate]
        for interval in intervalMiddles
        {
            let startInterval = interval.dateByAddingTimeInterval(Double(-error))
            //let endInterval = interval.dateByAddingTimeInterval(Double(error))
            let random = Int(arc4random_uniform(uError*2))
            let randomTime = startInterval.dateByAddingTimeInterval(Double(random))
            //print(randomTime)
            let hourFlags : NSCalendarUnit = [.Hour, .Minute]
            let hourComponents = NSCalendar.currentCalendar().components(hourFlags, fromDate: randomTime)
            let notificationComponents = NSDateComponents()
            notificationComponents.day = dayComponents.day
            notificationComponents.month = dayComponents.month
            notificationComponents.year = dayComponents.year
            notificationComponents.hour = hourComponents.hour
            notificationComponents.minute = hourComponents.minute
            let notificationTime = NSCalendar.currentCalendar().dateFromComponents(notificationComponents)
            print(notificationTime!)
            let notification = UILocalNotification()
            notification.alertBody = "How focued are you now?"
            notification.alertAction = "open"
            notification.fireDate = notificationTime!
            notification.soundName = UILocalNotificationDefaultSoundName
            notification.applicationIconBadgeNumber = 1
            UIApplication.sharedApplication().scheduleLocalNotification(notification)
        }

    }
}
