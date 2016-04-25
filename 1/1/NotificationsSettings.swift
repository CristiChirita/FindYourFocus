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
        
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
