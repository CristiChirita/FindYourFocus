//
//  SurveyPage5.swift
//  1
//
//  Created by Keshav Aggarwal on 20/03/16.
//  Copyright © 2016 University College London. All rights reserved.
//

import UIKit
import Firebase

class SurveyPage5: UIViewController {
    
    //let ref = Firebase (url: "https://testyourfocus.firebaseio.com")
    
    @IBOutlet weak var slider: UISlider!
    
    var scheduledNotifications = false

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let sampleRef = ref.childByAppendingPath("Users").childByAppendingPath(userData.stringForKey(Keys.UID)).childByAppendingPath("Samples").childByAppendingPath(userData.stringForKey(Keys.SAMPLENO)).childByAppendingPath("SliderValues")
        let value = slider.value
        sampleRef.updateChildValues(["Happiness level" : "\(value)"])
        let now = NSDate();
        ref.childByAppendingPath("Users").childByAppendingPath(userData.stringForKey(Keys.UID)).childByAppendingPath("Samples").childByAppendingPath(userData.stringForKey(Keys.SAMPLENO)).updateChildValues(["End Time" : "\(now)"])
        //SAMPLENO = SAMPLENO! + 1
        let newSampleCount = userData.integerForKey(Keys.SAMPLENO) + 1
        userData.setInteger(newSampleCount, forKey: Keys.SAMPLENO)
        let sample = [Keys.SAMPLENO : userData.integerForKey(Keys.SAMPLENO)]
        backupRef.childByAppendingPath(userData.stringForKey(Keys.UID)).updateChildValues(sample);
        //let now = NSDate()
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
            scheduleNotifications()
        }
        UIApplication.sharedApplication().applicationIconBadgeNumber = 0
        notificationfired = false
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "backgroundImage.png")!)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
