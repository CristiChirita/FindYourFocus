//
//  YourData.swift
//  1
//
//  Created by Keshav Aggarwal on 15/04/16.
//  Copyright © 2016 University College London. All rights reserved.
//

import UIKit

class YourData: UIViewController, UITableViewDelegate {
    
    let surveyCount = 30

    @IBOutlet weak var distractedBy: UILabel!
    @IBOutlet weak var focussedWhen: UILabel!
    var tableViewData = ["Focus Level by Activity"]
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "app background.png")!)

        // Do any additional setup after loading the view.
        
        
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        distractedBy.text = "You seem most distracted by: "
        focussedWhen.text = "It appears you are most focussed when you are: "

    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        if (surveyCount < 30) {
                
                let alert = UIAlertController(title: "Not enough data", message: "You have not completed enough surveys. Try again when you have done some more surveys.", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action)  -> Void in
                    
                    self.performSegueWithIdentifier("notEnoughData", sender: self)
                    
                }))
                self.presentViewController(alert, animated: true, completion: nil)
            
        }
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
        
        if(mySelectedCell.textLabel?.text == "Focus Level by Activity") {
            self.performSegueWithIdentifier("HorizontalBarGraph", sender: mySelectedCell)
            
        }
    }

    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let myNewCell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "Cell")
        myNewCell.textLabel?.text = tableViewData[indexPath.row]
        return myNewCell
        
    }
}
