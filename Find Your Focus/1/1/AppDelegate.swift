
//
//  AppDelegate.swift
//  1
//
//  Created by Keshav Aggarwal on 01/03/16.
//  Copyright © 2016 University College London. All rights reserved.
//

import UIKit
import Firebase

var UID : String?
var EMAIL: String?
var PASSWORD: String?
var NOTIFICATIONS: Int?
var SAMPLENO: Int?
var notificationfired = false

let userData = NSUserDefaults.standardUserDefaults();
let ref = Firebase (url: "https://findyourfocus.firebaseio.com")
let backupRef = ref.childByAppendingPath("Backup")


struct Keys {
    static let UID = "UID";
    static let EMAIL = "Email";
    static let PASSWORD = "Password";
    static let SAMPLENO = "SampleNo";
    static let AGE = "Age";
    static let WAKEUP = "WakeUpTime"
    static let SLEEP = "SleepTime";
    static let NOTIFICATIONS = "Notifications";
    static let ACTIVITIES = "Activities";
    static let ACTIVITYCOUNT = "ActivityCount";
    static let DISTRACTEDCOUNT = "DistractedCount"
    static let ACTIVITYFOCUSLEVEL = "ActivityFocusLevel";
    static let INTERVALMIDDLES = "Interval";
    static let INTERVALERROR = "Error";
    static let TOTALFOCUS = "TotalFocus";
    static let SIGNUPCOMPLETED = "SignUpCompleted";
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        UINavigationBar.appearance().barTintColor = UIColor(red: 20/255.0, green: 36/255.0, blue: 141/255.0, alpha: 1)
        
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor(), NSFontAttributeName: UIFont(name: "HelveticaNeue-Light", size: 19.0)!]
        
        UIBarButtonItem.appearance().tintColor = UIColor.whiteColor()
        
        UINavigationBar.appearance().tintColor = UIColor.whiteColor()
        
        Firebase.defaultConfig().persistenceEnabled = true
        
        application.registerUserNotificationSettings(UIUserNotificationSettings(forTypes: [.Alert, .Badge, .Sound], categories: nil))
        
        return true
    }
    
    

    
    
    
    // Function deals with notification if app is in the foreground
    func application(application: UIApplication, didReceiveLocalNotification notification: UILocalNotification) {
        // Do something serious in a real app.
//        print("Received Local Notification:")
//        print(notification.alertBody)
    }
    
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
        if UIApplication.sharedApplication().applicationIconBadgeNumber != 0
        {
            notificationfired = true
        }
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

