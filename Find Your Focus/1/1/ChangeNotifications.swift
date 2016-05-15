//
//  ChangeNotifications.swift
//  1
//
//  Created by cristi on 4/26/16.
//  Copyright © 2016 University College London. All rights reserved.
//

import UIKit

class ChangeNotifications: UIViewController {
    
    var pickerDataSource = ["1", "2", "3 (default)", "4", "5", "6", "7", "8", "9", "10"]
    
    @IBOutlet weak var number: UILabel!
    
    @IBOutlet weak var Note: UILabel!
    
    @IBOutlet weak var question: UILabel!
    
    @IBOutlet weak var numberOfNotifications: UIPickerView!
    
    var didChange : Bool?
    
    let defaultNotificationsNumber = 3
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "backgroundImage.png")!)
        
        //numberOfNotifications.selectRow(2, inComponent: 0, animated: true)
        
        didChange = false
        
        Note.text = " "
        
        question.text = "How many times a day would you like to receive questions?"
        print(userData.integerForKey(Keys.NOTIFICATIONS)-1)
        if (userData.integerForKey(Keys.NOTIFICATIONS)-1 >= 0)
        {
        number.text = pickerDataSource[userData.integerForKey(Keys.NOTIFICATIONS)-1]
        numberOfNotifications.selectRow(userData.integerForKey(Keys.NOTIFICATIONS)-1, inComponent: 0, animated: true)
        }
        else
        {
            number.text = pickerDataSource[2]
            numberOfNotifications.selectRow(2, inComponent: 0, animated: true)
            didChange = true
            userData.setInteger(3, forKey: Keys.NOTIFICATIONS)
            userData.synchronize()
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        
        return 1
        
    }
    
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return pickerDataSource.count
        
    }
    
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return pickerDataSource[row]
        
    }
    
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        number.text = pickerDataSource[row]
        print(row)
        userData.setInteger(row + 1 , forKey: Keys.NOTIFICATIONS)
        userData.synchronize()
        didChange = true
        
    }
    
    override func didMoveToParentViewController(parent: UIViewController?) {
        if didChange == false
        {
            return
        }
        let now = NSDate()
        let notificationList = UIApplication.sharedApplication().scheduledLocalNotifications!
        for notification in notificationList
        {
            if NSCalendar.currentCalendar().isDate(now, inSameDayAsDate: notification.fireDate!) == false
            {
                UIApplication.sharedApplication().cancelLocalNotification(notification)
            }
        }
        print("NOOO")
        setNotificationsIntervals()
        scheduleNotifications()
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
