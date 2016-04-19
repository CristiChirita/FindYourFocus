//
//  divertedYourAttention.swift
//  Survey
//
//  Created by Keshav Aggarwal on 03/03/16.
//  Copyright © 2016 University College London. All rights reserved.
//

import UIKit
import Firebase

class divertedYourAttention: UIViewController, UITableViewDelegate {

    var over18 = ["Notifications", "Games on phones/computer", "Browsing the internet", "Background noises", "TV", "Your music", "Family members", "Friends", "Thoughts unrelated to the task", "Advertising", "Other - please specify"]
    
     var below18 = ["Notifications", "Games on phones/computer", "Browsing the internet", "Background noises", "TV", "Your music", "Family members", "Friends", "Thoughts unrelated to the task", "Advertising", "Feeling Hungry", "Other - please specify"]
    
    var boolArray = [false, false, false, false, false, false, false, false, false, false, false, false]
    
    let lightOrange: UIColor = UIColor(red: 0.996, green: 0.467, blue: 0.224, alpha: 1)
    let medOrange: UIColor = UIColor(red: 0.973, green: 0.388, blue: 0.173, alpha: 1)
    let darkOrange: UIColor = UIColor(red: 0.796, green: 0.263, blue: 0.106, alpha: 1)
    let green: UIColor = UIColor(red: 0.251, green: 0.831, blue: 0.494, alpha: 1)
    let ref = Firebase(url: "https://testyourfocus.firebaseio.com")

    
    

    @IBOutlet weak var other: UITextView!
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let sampleRef = ref.childByAppendingPath("Users").childByAppendingPath(userData.stringForKey(Keys.UID)).childByAppendingPath("Samples").childByAppendingPath(userData.stringForKey(Keys.SAMPLENO)).childByAppendingPath("AttentionDiverted")
        var otherText : String
        if (boolArray[11] == true)
        {
            otherText = other.text
        }
        else { otherText = "false" }
        var attention = [ String : String]()//= ["Other" : otherText];
        for var i = 0; i<boolArray.count;i++
        {
            if (boolArray[i])
            {
                attention.updateValue("\(boolArray[i])", forKey: "\(over18[i])")
            }
        }
        if (otherText != "false")
        {
            attention.updateValue(otherText, forKey: "Other")
        }
        sampleRef.updateChildValues(attention)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "app background.png")!)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillShow:"), name:UIKeyboardWillShowNotification, object: nil);
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name:UIKeyboardWillHideNotification, object: nil);
        
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
        return over18.count
        
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
        
        myNewCell.textLabel?.text = over18[indexPath.row]
        
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
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
