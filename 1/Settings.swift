//
//  Settings.swift
//  1
//
//  Created by Keshav Aggarwal on 08/03/16.
//  Copyright © 2016 University College London. All rights reserved.
//

import UIKit
import Firebase

class Settings: UIViewController, UITableViewDelegate {
    
    var ref = Firebase(url: "https://testyourfocus.firebaseio.com")
    
    var tableViewData = ["Waking Hours", "Notifications"]

    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "backgroundImage.png")!)

        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    }

    
    @IBAction func deleteAccountPressed(sender: UIButton) {
        
        // create the alert
        let alert = UIAlertController(title: "Delete Account", message: "Are you sure you want to delete your account?", preferredStyle: UIAlertControllerStyle.Alert)
        
        // add the actions (buttons)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .Destructive, handler: nil))
        
        alert.addAction(UIAlertAction(title: "Continue", style: .Destructive, handler: { (action)  -> Void in
            
            self.ref.removeUser(userData.stringForKey(Keys.EMAIL), password: userData.stringForKey(Keys.PASSWORD), withCompletionBlock:
                {
                    error in
                    if error != nil
                    {
                        print("Nope")
                    }
                    else
                    {
                        userData.setValue(nil, forKey: Keys.EMAIL)
                        userData.setValue(nil, forKey: Keys.UID)
                        userData.setValue(nil, forKey: Keys.PASSWORD)
                        self.ref.unauth()
                    }
            })
            
            self.performSegueWithIdentifier("accountDeleted", sender: sender)
            
        }))
        
        
        // show the alert
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
    

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewData.count
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        
        let mySelectedCell: UITableViewCell = tableView.cellForRowAtIndexPath(indexPath)!
        
        if(mySelectedCell.textLabel?.text == "Waking Hours") {
            
            self.performSegueWithIdentifier("SettingsToWakingHours", sender: mySelectedCell)
            
        } else if(mySelectedCell.textLabel?.text == "Notifications") {
            
            self.performSegueWithIdentifier("SettingsToNotifications", sender: mySelectedCell)
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let myNewCell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "cell")
        
        myNewCell.textLabel?.text = tableViewData[indexPath.row]
        myNewCell.accessoryType = .DisclosureIndicator
        
        
        return myNewCell
        
    }



}
