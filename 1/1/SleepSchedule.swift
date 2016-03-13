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
    
//    @IBOutlet weak var wakeUpTimeSelect: UIDatePicker!
    
    @IBOutlet weak var wakeUpTimeSelect: UIDatePicker!
    
    @IBOutlet weak var sleepTimeSelect: UIDatePicker!
    
    @IBOutlet weak var note: UILabel!
    
    @IBOutlet weak var question: UILabel!
    
    let wakeUpTap = UITapGestureRecognizer()
    let sleepTap = UITapGestureRecognizer()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        note.text = "We will not send any notifications within one hour of your usual waking or sleeping times."
        
        question.text = "What times of the day are you usually awake?"
        
        wakeUpTap.addTarget(self, action: "wakeUpTappedView")
        wakeUp.addGestureRecognizer(wakeUpTap)
        wakeUp.userInteractionEnabled = true
        
        sleepTap.addTarget(self, action: "sleepTappedView")
        sleep.addGestureRecognizer(sleepTap)
        sleep.userInteractionEnabled = true
        
    }
    
    
    @IBAction func wakeUpTimeChanged(sender: UIDatePicker) {
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "hh:mm a"
        let strDate = dateFormatter.stringFromDate(sender.date)
        wakeUp.text = strDate
        
    }
    
    
    @IBAction func sleepTimeChanged(sender: UIDatePicker) {
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "hh:mm a"
        let strDate = dateFormatter.stringFromDate(sender.date)
        sleep.text = strDate
        
//        if(dateFormatter.stringFromDate(sender.date) < dateFormatter.stringFromDate(sleepTimeSelect.date)) {
//            
//            next.enabled = false
//            
//        } else {
//            
//            next.enabled = true
//            
//        }
        
    }
    
    
    func wakeUpTappedView(){
        
        if (wakeUpTimeSelect.hidden == true) {
            
            wakeUpTimeSelect.hidden = false

        } else {
            
            wakeUpTimeSelect.hidden = true
            
        }
        
        sleepTimeSelect.hidden = true
        
    }
    
    func sleepTappedView(){
        
        if (sleepTimeSelect.hidden == true) {
            
            sleepTimeSelect.hidden = false
            
        } else {
            
            sleepTimeSelect.hidden = true
            
        }
        
        wakeUpTimeSelect.hidden = true
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
