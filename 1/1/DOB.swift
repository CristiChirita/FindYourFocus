//
//  DOB.swift
//  1
//
//  Created by Keshav Aggarwal on 06/03/16.
//  Copyright © 2016 University College London. All rights reserved.
//

import UIKit
import Firebase

class DOB: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var dob: UITextField!
    @IBOutlet weak var next: UIBarButtonItem!
    //var ref = Firebase(url: "https://testyourfocus.firebaseio.com")

    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "backgroundImage.png")!)
        
        dob.delegate = self
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillShow:"), name:UIKeyboardWillShowNotification, object: nil);
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name:UIKeyboardWillHideNotification, object: nil);
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        //print("Does work!")
        var age : Int
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy"
        let date = dateFormatter.dateFromString(dob.text!)
        //let now : NSDate = NSDate()
        let calendar : NSCalendar = NSCalendar.currentCalendar()
        let unitFlags : NSCalendarUnit = [NSCalendarUnit.Year, NSCalendarUnit.Month, NSCalendarUnit.Day]
        let dateComponentNow : NSDateComponents = calendar.components(unitFlags, fromDate: NSDate())
        let dateComponentBirth : NSDateComponents = calendar.components(unitFlags, fromDate: date!)
        
        if ( (dateComponentNow.month < dateComponentBirth.month) ||
            ((dateComponentNow.month == dateComponentBirth.month) && (dateComponentNow.day < dateComponentBirth.day))
            )
        {
            age =  dateComponentNow.year - dateComponentBirth.year - 1
        }
        else {
            age = dateComponentNow.year - dateComponentBirth.year
        }
        print(age)
        let userAge = ["age" : age]
        ref.childByAppendingPath("Users").childByAppendingPath(userData.stringForKey(Keys.UID)).childByAppendingPath("Data").updateChildValues(userAge)
        userData.setInteger(age, forKey: Keys.AGE)
    }
    
    func keyboardWillShow(sender: NSNotification) {
        self.view.frame.origin.y = -20
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
    
    func textFieldDidBeginEditing(textField: UITextField) {
        
        let datePicker = UIDatePicker()
        
        datePicker.datePickerMode = UIDatePickerMode.Date
        
        let calendar: NSCalendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
        let currentDate: NSDate = NSDate()
        let comps: NSDateComponents = NSDateComponents()
        comps.year = -12
        let maxDate: NSDate = calendar.dateByAddingComponents(comps, toDate: currentDate, options: NSCalendarOptions(rawValue: 0))!
        comps.year = -100
        let minDate: NSDate = calendar.dateByAddingComponents(comps, toDate: currentDate, options: NSCalendarOptions(rawValue: 0))!
        datePicker.maximumDate = maxDate
        datePicker.minimumDate = minDate

        dob.inputView = datePicker
        
        datePicker.addTarget(self, action: "datePickerChanged:", forControlEvents: .ValueChanged)
        
    }
    
    @IBAction func textFieldDidEndEditting(sender: AnyObject) {
        
        if(dob.text == "") {
            next.enabled = false
        } else {
            next.enabled = true
        }
        
    }
    func datePickerChanged(sender: UIDatePicker) {
        
        let dateFormatter = NSDateFormatter()
        
        dateFormatter.dateFormat = "dd MMM yyyy"
        
        dob.text = dateFormatter.stringFromDate(sender.date)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
