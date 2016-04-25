//
//  areYouCurrently.swift
//  Survey
//
//  Created by Keshav Aggarwal on 03/03/16.
//  Copyright © 2016 University College London. All rights reserved.
//

import UIKit
import Firebase

class areYouCurrently: UIViewController, UITableViewDelegate, UITextViewDelegate {

    @IBOutlet weak var other: UITextView!
    
    var over18 = ["Alone", "With friends", "With family", "With partner or significant other", "On a date", "With children", "With colleagues", "Other - please specify"]
   
     var below18 = ["Alone", "With friends", "With family", "With partner or significant other", "On a date", "Other - please specify"]
    
    var boolArray: [Bool] = []
    
    var finalArray: [String] = []
    
    let lightOrange: UIColor = UIColor(red: 0.996, green: 0.467, blue: 0.224, alpha: 1)
    let medOrange: UIColor = UIColor(red: 0.973, green: 0.388, blue: 0.173, alpha: 1)
    let darkOrange: UIColor = UIColor(red: 0.796, green: 0.263, blue: 0.106, alpha: 1)
    let green: UIColor = UIColor(red: 0.251, green: 0.831, blue: 0.494, alpha: 1)
    //let ref = Firebase (url: "https://testyourfocus.firebaseio.com")


    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "backgroundImage.png")!)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillShow:"), name:UIKeyboardWillShowNotification, object: nil);
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name:UIKeyboardWillHideNotification, object: nil);
        
        
        if userData.integerForKey(Keys.AGE) < 18 {
            copyArray(below18)
        } else {
            copyArray(over18)
        }

        
    }
    
    func copyArray(arr: [String]) {
        for item in arr {
            finalArray.append(item)
            boolArray.append(false)
        }
    }
    
   /* override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var otherText : String
        let sampleRef = ref.childByAppendingPath("Users").childByAppendingPath(userData.stringForKey(Keys.UID)).childByAppendingPath("Samples").childByAppendingPath(userData.stringForKey(Keys.SAMPLENO)).childByAppendingPath("Company")
        var companyData = [ String : String]()
        if (userData.integerForKey(Keys.AGE)>=18)
        {
        if (boolArray[over18.count-1] == true) {
            otherText = other.text
        }
        else { otherText = "false" }
        
        for var i = 0; i<over18.count - 1 ;i++
        {
            if (boolArray[i])
            {
                companyData.updateValue("\(boolArray[i])", forKey: "\(over18[i])")
            }
        }
        if (otherText != "false")
        {
            companyData.updateValue(otherText, forKey: "Other")
        }
        }
        else {
            if (boolArray[below18.count-1] == true) {
                otherText = other.text
            }
            else { otherText = "false" }
            //var companyData = [ String : String]()
            for var i = 0; i<below18.count - 1 ;i++
            {
                if (boolArray[i])
                {
                    companyData.updateValue("\(boolArray[i])", forKey: "\(below18[i])")
                }
            }
            if (otherText != "false")
            {
                companyData.updateValue(otherText, forKey: "Other")
            }

        }
        sampleRef.setValue(companyData)
    }*/
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var otherText : String
        let sampleRef = ref.childByAppendingPath("Users").childByAppendingPath(userData.stringForKey(Keys.UID)).childByAppendingPath("Samples").childByAppendingPath(userData.stringForKey(Keys.SAMPLENO)).childByAppendingPath("Company")
        if (boolArray[finalArray.count-1] == true) {
            otherText = other.text
        }
        else { otherText = "false" }
        var companyData = [ String : String]()
        
        for var i = 0; i<finalArray.count;i++
        {
            if (boolArray[i])
            {
                companyData.updateValue("\(boolArray[i])", forKey: "\(finalArray[i])")
            }
        }
        if (otherText != "false")
        {
            companyData.updateValue(otherText, forKey: "Other")
        }
        sampleRef.setValue(companyData)
    }
    
    func keyboardWillShow(sender: NSNotification) {
        self.view.frame.origin.y = -210
    }
    
    func keyboardWillHide(sender: NSNotification) {
        self.view.frame.origin.y = 0
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        tableView.backgroundColor = darkOrange
        return finalArray.count
        
    }
    
    
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        
        let mySelectedCell: UITableViewCell = tableView.cellForRowAtIndexPath(indexPath)!
        
        mySelectedCell.tintColor = UIColor.whiteColor()
        
        if(mySelectedCell.accessoryType == UITableViewCellAccessoryType.None) {
            
            mySelectedCell.accessoryType = UITableViewCellAccessoryType.Checkmark
            
            mySelectedCell.backgroundColor = green
            
            boolArray[indexPath.row] = true
            
            if(mySelectedCell.textLabel?.text == "Other - please specify") {
                
                other.hidden = false;
                
            }
            
        } else {
            
            mySelectedCell.accessoryType = UITableViewCellAccessoryType.None
            
            mySelectedCell.backgroundColor = medOrange
            
            boolArray[indexPath.row] = false
            
            if(mySelectedCell.textLabel?.text == "Other - please specify") {
                
                other.hidden = true;
                
            }
        }
        
    }
    
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let myNewCell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "myCell")
        
        myNewCell.textLabel?.text = finalArray[indexPath.row]
        
        myNewCell.backgroundColor = medOrange
        
        myNewCell.textLabel?.textColor = UIColor.whiteColor()
        
        myNewCell.tintColor = UIColor.whiteColor()
        
        myNewCell.selectionStyle = UITableViewCellSelectionStyle.None
        
        if(boolArray[indexPath.row]){
            myNewCell.accessoryType = UITableViewCellAccessoryType.Checkmark
            myNewCell.backgroundColor = green
        } else {
            
            myNewCell.accessoryType = UITableViewCellAccessoryType.None
            myNewCell.backgroundColor = medOrange
        }
        
        return myNewCell
        
    }


}
