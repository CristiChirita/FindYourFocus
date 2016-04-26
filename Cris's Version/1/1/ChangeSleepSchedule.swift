//
//  ChangeSleepSchedule.swift
//  1
//
//  Created by cristi on 4/26/16.
//  Copyright © 2016 University College London. All rights reserved.
//

import UIKit

class ChangeSleepSchedule: UIViewController {
    
    
    @IBOutlet weak var wakeUp: UILabel!

    @IBOutlet weak var sleep: UILabel!
    
    @IBOutlet weak var wakeUpTimeSelect: UIDatePicker!

    @IBOutlet weak var note: UILabel!
    
    @IBOutlet weak var sleepTimeSelect: UIDatePicker!
    
    @IBOutlet weak var question: UILabel!
    
    @IBOutlet weak var datePickerLabel: UILabel!
    
    let wakeUpTap = UITapGestureRecognizer()
    let sleepTap = UITapGestureRecognizer()
    
    let calendar: NSCalendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
    let comps: NSDateComponents = NSDateComponents()
    
    let dateFormatter = NSDateFormatter()

    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
        wakeUp.text = dateFormatter.stringFromDate((userData.objectForKey(Keys.WAKEUP) as! NSDate).dateByAddingTimeInterval(-30*60))
        sleep.text = dateFormatter.stringFromDate((userData.objectForKey(Keys.SLEEP) as! NSDate).dateByAddingTimeInterval(30*60))

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func wakeUpTimeChanged(sender: AnyObject) {
        
        let strDate = dateFormatter.stringFromDate(sender.date)
        wakeUp.text = strDate
        
        let minSleepTime: NSDate = calendar.dateByAddingComponents(comps, toDate: sender.date, options: NSCalendarOptions(rawValue: 0))!
        
        
        sleepTimeSelect.minimumDate = minSleepTime
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func sleepTimeChanged(sender: AnyObject) {
        let strDate = dateFormatter.stringFromDate(sender.date)
        sleep.text = strDate
        
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
    
    override func didMoveToParentViewController(parent: UIViewController?) {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "hh:mm a"
        let wakeUpInitial = dateFormatter.stringFromDate((userData.objectForKey(Keys.WAKEUP) as! NSDate).dateByAddingTimeInterval(-30*60))
        let sleepInitial = dateFormatter.stringFromDate((userData.objectForKey(Keys.SLEEP) as! NSDate).dateByAddingTimeInterval(30*60))
        if (wakeUp.text! != wakeUpInitial || sleep.text! != sleepInitial)
        {

            userData.setObject((dateFormatter.dateFromString(wakeUp.text!))!.dateByAddingTimeInterval(30*60), forKey: Keys.WAKEUP)
            userData.synchronize()
            let wakeUpDelay = dateFormatter.stringFromDate((dateFormatter.dateFromString(wakeUp.text!))!.dateByAddingTimeInterval(30*60))
            userData.setObject((dateFormatter.dateFromString(sleep.text!))!.dateByAddingTimeInterval(-30*60), forKey: Keys.SLEEP)
            userData.synchronize()
            let sleepDelay = dateFormatter.stringFromDate((dateFormatter.dateFromString(sleep.text!))!.dateByAddingTimeInterval(-30*60))
            backupRef.childByAppendingPath(userData.stringForKey(Keys.UID)).updateChildValues([Keys.WAKEUP : wakeUpDelay, Keys.SLEEP : sleepDelay])
            let now = NSDate()
            let notificationList = UIApplication.sharedApplication().scheduledLocalNotifications!
            for notification in notificationList
            {
                if NSCalendar.currentCalendar().isDate(now, inSameDayAsDate: notification.fireDate!) == false
                {
                    UIApplication.sharedApplication().cancelLocalNotification(notification)
                }
            }
            setNotificationsIntervals()
            scheduleNotifications()
        }
    }
    
    func setNotificationsIntervals()
    {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "hh:mm a"
        let wakeup = userData.objectForKey(Keys.WAKEUP) as! NSDate
        let sleep = userData.objectForKey(Keys.SLEEP) as! NSDate
        let activeTime = sleep.timeIntervalSinceDate(wakeup)
        //let activeTimeInt =  (Int) activeTime
        print(activeTime)
        print(userData.integerForKey(Keys.NOTIFICATIONS))
        if (activeTime-3600.0)/3600.0 < Double(userData.integerForKey(Keys.NOTIFICATIONS))
        {
            userData.setInteger(Int(activeTime/3600.0-1), forKey: Keys.NOTIFICATIONS)
            userData.synchronize()
        }
        print(userData.integerForKey(Keys.NOTIFICATIONS))
        let intervalLength = Int(activeTime) / userData.integerForKey(Keys.NOTIFICATIONS)
        var currentIntervalStart = wakeup
        var intervalMiddles = [NSDate]()
        for _ in 1...userData.integerForKey(Keys.NOTIFICATIONS)
        {
            intervalMiddles += [currentIntervalStart.dateByAddingTimeInterval(Double(intervalLength/2))]
            currentIntervalStart = currentIntervalStart.dateByAddingTimeInterval(Double(intervalLength))
        }
        let error = Int(intervalMiddles[0].timeIntervalSinceDate(wakeup.dateByAddingTimeInterval(30*60)))
        userData.setObject(intervalMiddles, forKey: Keys.INTERVALMIDDLES)
        //intervalMiddles += [dateFormatter.dateFromString("00:00 AM")!]
        var intervalMiddlesStrings = [String]()
        for interval in intervalMiddles
        {
            intervalMiddlesStrings.append(dateFormatter.stringFromDate(interval))
        }
        intervalMiddlesStrings.append("00:00 AM")
        backupRef.childByAppendingPath(userData.stringForKey(Keys.UID)).childByAppendingPath("IntervalMiddles").setValue(intervalMiddlesStrings)
        userData.setInteger(error, forKey: Keys.INTERVALERROR)
        backupRef.childByAppendingPath(userData.stringForKey(Keys.UID)).updateChildValues([Keys.INTERVALERROR : error])
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
            var notification = UILocalNotification()
            notification.alertBody = "How focued are you now?"
            notification.alertAction = "open"
            notification.fireDate = notificationTime!
            notification.soundName = UILocalNotificationDefaultSoundName
            notification.applicationIconBadgeNumber = 1
            UIApplication.sharedApplication().scheduleLocalNotification(notification)
        }
        
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
