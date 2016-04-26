//
//  NotificationsSettings.swift
//  1
//
//  Created by Keshav Aggarwal on 02/03/16.
//  Copyright © 2016 University College London. All rights reserved.
//

import UIKit

class NotificationsSettings: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    var pickerDataSource = ["1", "2", "3 (default)", "4", "5", "6", "7", "8", "9", "10"]
    
    @IBOutlet weak var numberOfNotifications: UIPickerView!
    
    @IBOutlet weak var Note: UILabel!
    
    @IBOutlet weak var question: UILabel!
    
    @IBOutlet weak var number: UILabel!
    
    var didChange = false
    
    let defaultNotificationsNumber = 3
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "backgroundImage.png")!)
        
        numberOfNotifications.selectRow(2, inComponent: 0, animated: true)
        
        Note.text = "We will send you a short set of questions about your current level focus at times throughout the day."
        
        question.text = "How many times a day would you like to receive questions?"
        
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
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        //let notificationsNO =
        setNotificationsIntervals();
    }
    
    func setNotificationsIntervals()
    {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "hh:mm a"
        let wakeup = userData.objectForKey(Keys.WAKEUP) as! NSDate
        let sleep = userData.objectForKey(Keys.SLEEP) as! NSDate
        let activeTime = sleep.timeIntervalSinceDate(wakeup)
        if didChange == false
        {
            userData.setInteger(defaultNotificationsNumber, forKey: Keys.NOTIFICATIONS)
            userData.synchronize()
        }
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
    
 /*   func applicationWillTerminate(application: UIApplication) {
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
