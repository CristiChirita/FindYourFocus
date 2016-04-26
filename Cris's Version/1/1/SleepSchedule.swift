//
//  SleepSchedule.swift
//  1
//
//  Created by Keshav Aggarwal on 02/03/16.
//  Copyright © 2016 University College London. All rights reserved.
//

import UIKit

class SleepSchedule: UIViewController {

    @IBOutlet weak var wakeUp: UILabel!
    
    @IBOutlet weak var sleep: UILabel!
    
    @IBOutlet weak var wakeUpTimeSelect: UIDatePicker!
    
    @IBOutlet weak var sleepTimeSelect: UIDatePicker!
    
    @IBOutlet weak var note: UILabel!
    
    @IBOutlet weak var question: UILabel!
    
    @IBOutlet weak var datePickerLabel: UILabel!
    
    let wakeUpTap = UITapGestureRecognizer()
    let sleepTap = UITapGestureRecognizer()
    
    let calendar: NSCalendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
    let comps: NSDateComponents = NSDateComponents()
    
    
    let dateFormatter = NSDateFormatter()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "backgroundImage.png")!)
        
        
        note.text = "Note: We will not send any notifications within one hour of your usual waking or sleeping times."
        
        question.text = "What times of the day are you usually awake?"
        
        wakeUpTap.addTarget(self, action: "wakeUpTappedView")
        wakeUp.addGestureRecognizer(wakeUpTap)
        wakeUp.userInteractionEnabled = true
        
        sleepTap.addTarget(self, action: "sleepTappedView")
        sleep.addGestureRecognizer(sleepTap)
        sleep.userInteractionEnabled = true
        
        dateFormatter.dateFormat = "hh:mm a"
    }
    
    
    @IBAction func wakeUpTimeChanged(sender: UIDatePicker) {
        
        
        let strDate = dateFormatter.stringFromDate(sender.date)
        wakeUp.text = strDate
        
        comps.hour = 2
        let minSleepTime: NSDate = calendar.dateByAddingComponents(comps, toDate: sender.date, options: NSCalendarOptions(rawValue: 0))!
        
        
        sleepTimeSelect.minimumDate = minSleepTime
        
    }
    
    
    @IBAction func sleepTimeChanged(sender: UIDatePicker) {
        
        
        let strDate = dateFormatter.stringFromDate(sender.date)
        sleep.text = strDate

        comps.hour = -2
        let maxWakeUpTime: NSDate = calendar.dateByAddingComponents(comps, toDate: sender.date, options: NSCalendarOptions(rawValue: 0))!
        
        wakeUpTimeSelect.maximumDate = maxWakeUpTime
        
    }
    
    
    func wakeUpTappedView(){
        
        if (wakeUpTimeSelect.hidden == true) {
            
            wakeUpTimeSelect.hidden = false
            datePickerLabel.hidden = false
            datePickerLabel.text = "Wake Up Time"

        } else {
            
            wakeUpTimeSelect.hidden = true
            datePickerLabel.hidden = true
            
        }
        
        sleepTimeSelect.hidden = true
        
    }
    
    func sleepTappedView(){
        
        if (sleepTimeSelect.hidden == true) {
            
            sleepTimeSelect.hidden = false
            datePickerLabel.hidden = false
            datePickerLabel.text = "Sleep Time"
            
        } else {
            
            sleepTimeSelect.hidden = true
            datePickerLabel.hidden = true
            
        }
        
        wakeUpTimeSelect.hidden = true
        
    }
    
    func alertMessage(title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
    
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
        
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
    
    @IBAction func next(sender: UIBarButtonItem) {
        if(wakeUp.text == "Wake Up Time" || sleep.text == "Sleep Time") {
            alertMessage("Time Not Selected", message: "Please select both the wake up and the sleep time.")
        } else {
            self.performSegueWithIdentifier("wakingHoursToNotifications", sender: sender)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
      
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "hh:mm a"
        userData.setObject((dateFormatter.dateFromString(wakeUp.text!))!.dateByAddingTimeInterval(30*60), forKey: Keys.WAKEUP)
        userData.synchronize()
        let wakeUpDelay = dateFormatter.stringFromDate((dateFormatter.dateFromString(wakeUp.text!))!.dateByAddingTimeInterval(30*60))
        userData.setObject((dateFormatter.dateFromString(sleep.text!))!.dateByAddingTimeInterval(-30*60), forKey: Keys.SLEEP)
        userData.synchronize()
        let sleepDelay = dateFormatter.stringFromDate((dateFormatter.dateFromString(sleep.text!))!.dateByAddingTimeInterval(-30*60))
        backupRef.childByAppendingPath(userData.stringForKey(Keys.UID)).updateChildValues([Keys.WAKEUP : wakeUpDelay, Keys.SLEEP : sleepDelay])
        //backupRef.childByAppendingPath(userData.stringForKey(Keys.UID)).updateChildValues([Keys.WAKEUP : (dateFormatter.dateFromString(wakeUp.text!))!.dateByAddingTimeInterval(30*60), Keys.SLEEP : (dateFormatter.dateFromString(sleep.text!))!.dateByAddingTimeInterval(-30*60)])
    }
    
  /*  func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        ref.removeUser(userData.stringForKey(Keys.EMAIL), password: userData.stringForKey(Keys.PASSWORD), withCompletionBlock:
            {
                error in
                if error != nil
                {
                    print("Nope")
                }
                else
                {
                    backupRef.childByAppendingPath(userData.stringForKey(Keys.UID)).removeValue()
                    userData.setValue(nil, forKey: Keys.EMAIL)
                    userData.setValue(nil, forKey: Keys.UID)
                    userData.setValue(nil, forKey: Keys.PASSWORD)
                    ref.unauth()
                }
        })
    } */

}
