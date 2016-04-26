//
//  CopyrightsViewController.swift
//  1
//
//  Created by Keshav Aggarwal on 15/04/16.
//  Copyright © 2016 University College London. All rights reserved.
//

import UIKit

class CopyrightsViewController: UIViewController, UITableViewDelegate {

    var tableViewData = ["Icons: iconfinder.com - License", "Charts - License", "Charts - GitHub Repository", "Reveal View Controller - License", "Reveal View Controller - GitHub repository"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewData.count
    }

    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        
        let mySelectedCell: UITableViewCell = tableView.cellForRowAtIndexPath(indexPath)!
        
        if(mySelectedCell.textLabel?.text == "Icons: iconfinder.com - License") {
            if let url = NSURL(string: "https://www.iconfinder.com/licenses/basic") {
                UIApplication.sharedApplication().openURL(url)
            }
        } else if(mySelectedCell.textLabel?.text == "Charts - License"){
            
            self.performSegueWithIdentifier("Charts - License", sender: mySelectedCell)
            
        } else if(mySelectedCell.textLabel?.text == "Charts - GitHub Repository"){
            if let url = NSURL(string: "https://github.com/danielgindi/Charts") {
                UIApplication.sharedApplication().openURL(url)
            }
        } else if(mySelectedCell.textLabel?.text == "Reveal View Controller - License"){
            
            self.performSegueWithIdentifier("Reveal View Controller - License", sender: mySelectedCell)
            
        } else if(mySelectedCell.textLabel?.text == "Reveal View Controller - GitHub repository"){
            if let url = NSURL(string: "https://github.com/John-Lluch/SWRevealViewController") {
                UIApplication.sharedApplication().openURL(url)
            }
        }

    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let myNewCell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "Cell")
        myNewCell.textLabel?.text = tableViewData[indexPath.row]
        return myNewCell
        
    }

    
}
