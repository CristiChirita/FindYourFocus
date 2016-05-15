//
//  Menu.swift
//  1
//
//  Created by Keshav Aggarwal on 24/04/16.
//  Copyright © 2016 University College London. All rights reserved.
//

import UIKit
import Firebase

class Menu: UITableViewController {

    @IBOutlet weak var signOut: UITableViewCell!
    var tapRecognizer = UITapGestureRecognizer()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        tapRecognizer.addTarget(self, action: "signingOut:")
        signOut.addGestureRecognizer(tapRecognizer)
    }
    
    func signingOut(sender: UITapGestureRecognizer) {
        let notificationList = UIApplication.sharedApplication().scheduledLocalNotifications!
        for notification in notificationList
        {
            UIApplication.sharedApplication().cancelLocalNotification(notification)
        }
        ref.unauth()
        userData.setObject(nil, forKey: Keys.UID)
        userData.synchronize()
        UIApplication.sharedApplication().applicationIconBadgeNumber = 0
        self.performSegueWithIdentifier("signOut", sender: sender)
    }
}
