//
//  divertedYourAttention.swift
//  Survey
//
//  Created by Keshav Aggarwal on 03/03/16.
//  Copyright © 2016 University College London. All rights reserved.
//

import UIKit

class divertedYourAttention: UIViewController, UITableViewDelegate {

    var tableViewData = ["Notifiactions", "Games on phones/computer", "Browsing the internet", "Background noises", "TV", "Your music", "Family members", "Friends", "Browsinf the internet", "Thoughts unrelated to the task", "Advertising", "Other - please specify"]
    
    let lightOrange: UIColor = UIColor(red: 0.996, green: 0.467, blue: 0.224, alpha: 1)
    let medOrange: UIColor = UIColor(red: 0.973, green: 0.388, blue: 0.173, alpha: 1)
    let darkOrange: UIColor = UIColor(red: 0.796, green: 0.263, blue: 0.106, alpha: 1)
    let green: UIColor = UIColor(red: 0.251, green: 0.831, blue: 0.494, alpha: 1)
    
    
    @IBOutlet weak var other: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        tableView.backgroundColor = darkOrange
        return tableViewData.count
        
    }
    
    
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        
        let mySelectedCell: UITableViewCell = tableView.cellForRowAtIndexPath(indexPath)!
        
        mySelectedCell.tintColor = UIColor.whiteColor()
        
        if(mySelectedCell.accessoryType == UITableViewCellAccessoryType.None) {
            
            mySelectedCell.accessoryType = UITableViewCellAccessoryType.Checkmark
            
            mySelectedCell.backgroundColor = green
            
            if(mySelectedCell.textLabel?.text == "Other - please specify") {
                
                other.hidden = false;
                
            }
            
        } else {
            
            mySelectedCell.accessoryType = UITableViewCellAccessoryType.None
            
            mySelectedCell.backgroundColor = medOrange
            
            if(mySelectedCell.textLabel?.text == "Other - please specify") {
                
                other.hidden = true;
                
            }
        }
        
    }
    
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let myNewCell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "myCell")
        
        myNewCell.textLabel?.text = tableViewData[indexPath.row]
        
        myNewCell.backgroundColor = medOrange
        
        myNewCell.textLabel?.textColor = UIColor.whiteColor()
        
        return myNewCell
        
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
