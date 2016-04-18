//
//  DOB.swift
//  1
//
//  Created by Keshav Aggarwal on 06/03/16.
//  Copyright © 2016 University College London. All rights reserved.
//

import UIKit

class DOB: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var dob: UITextField!
    @IBOutlet weak var next: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "app background.png")!)
        
        dob.delegate = self
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillShow:"), name:UIKeyboardWillShowNotification, object: nil);
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name:UIKeyboardWillHideNotification, object: nil);
        
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
