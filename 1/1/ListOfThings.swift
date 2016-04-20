//
//  ListOfThings.swift
//  1
//
//  Created by Keshav Aggarwal on 13/03/16.
//  Copyright © 2016 University College London. All rights reserved.
//

import UIKit
import Firebase

class ListOfThings: UITableViewController {
    
    var over18 = ["Resting or sleeping", "Walking", "Watching TV, film, online videos", "News watching", "Listening to music", "Listening to a radio program", "Gaming", "Playing board games", "Childcare", "Playing Sport", "Working", "Studying", "Intimate relations", "Exercising", "Eating", "Reading (books, paper, online)", "Cooking", "Praying/meditating", "Online Chatting", "Email", "Surfing the net", "Engaging with family member", "Engaging with friends", "Shopping, running errands", "Household admin", "Travelling"]
    
    var below18 = ["Resting or sleeping", "Walking", "Watching TV, film, online videos", "News watching", "Listening to music", "Listening to a radio program or podcast", "Gaming", "Playing board games", "Childcare", "Playing Sport", "Working", "Studying/ homework", "Exercising", "Eating", "Reading (books, paper, online)", "Cooking", "Praying/meditating", "Online Chatting", "Email", "Surfing the net", "Engaging with family member", "Engaging with friends", "Shopping, running errands", "Household chores", "Travelling"]
    
    var boolArray = [false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false]
    
    
    let lightOrange: UIColor = UIColor(red: 0.996, green: 0.467, blue: 0.224, alpha: 1)
    let medOrange: UIColor = UIColor(red: 0.973, green: 0.388, blue: 0.173, alpha: 1)
    let darkOrange: UIColor = UIColor(red: 0.796, green: 0.263, blue: 0.106, alpha: 1)
    let green: UIColor = UIColor(red: 0.251, green: 0.831, blue: 0.494, alpha: 1)
    let ref = Firebase(url: "https://testyourfocus.firebaseio.com")
    
    override func didMoveToParentViewController(parent: UIViewController?) {
        if (!(parent?.isEqual(self.parentViewController) ?? false)) {
            print("Back Button Pressed!")
            let sampleRef = ref.childByAppendingPath("Users").childByAppendingPath(userData.stringForKey(Keys.UID)).childByAppendingPath("Samples").childByAppendingPath(userData.stringForKey(Keys.SAMPLENO)).childByAppendingPath("LastAction")
            var tableData = [String : String]()
            for var i = 0; i<boolArray.count;i++
            {
                if (boolArray[i])
                {
                    if (userData.integerForKey(Keys.AGE)>=18)
                    {
                        tableData.updateValue("\(boolArray[i])", forKey: "\(over18[i])")
                    }
                    else
                    {
                        tableData.updateValue("\(boolArray[i])", forKey: "\(below18[i])")
                    }
                }
            }
            sampleRef.updateChildValues(tableData)
            
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableView.backgroundColor = darkOrange
        return over18.count
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        
        let mySelectedCell: UITableViewCell = tableView.cellForRowAtIndexPath(indexPath)!
        
        mySelectedCell.tintColor = UIColor.whiteColor()
        
        if(mySelectedCell.accessoryType == UITableViewCellAccessoryType.None) {
            
            mySelectedCell.accessoryType = UITableViewCellAccessoryType.Checkmark
            
            boolArray[indexPath.row] = true
            
            mySelectedCell.backgroundColor = green
            
        } else {
            
            mySelectedCell.accessoryType = UITableViewCellAccessoryType.None
            
            boolArray[indexPath.row] = false
            
            mySelectedCell.backgroundColor = medOrange
            
        }
    }

    
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
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

}
