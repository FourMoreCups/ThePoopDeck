//
//  AppDelegate.swift
//  The Poop Deck
//
//  Created by Sean Deaton on 5/21/15.
//  Copyright (c) 2015 Sean Deaton. All rights reserved.
//

import UIKit
import WatchConnectivity

@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate, WCSessionDelegate {

    var window: UIWindow?
    

    enum ShortcutType: String {
        case MealShortcut = "com.seandeaton.The-Poop-Deck.mealshortcut"
    }

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        //check for shortcut item
        
        Push.initializeNotificationServices()
        
        if #available(iOS 9.0, *) {
            if let shortcutItem = launchOptions?[UIApplicationLaunchOptionsShortcutItemKey] as! UIApplicationShortcutItem?{
                self.handleShortcutItem(shortcutItem)
            }
        } else {
            // Fallback on earlier versions
        }
        
        if #available(iOS 9.0, *) {
            if WCSession.isSupported() {
                let session = WCSession.defaultSession()
                session.delegate = self
                session.activateSession()
                
                if session.paired.boolValue != true {
                    print("Apple Watch not paired")
                }
                if session.watchAppInstalled.boolValue != true {
                    print("Apple Watch paired but App not installed")
                }
            }
            else{
                print("Watch connectivity not supported")
            }
        } else {
            // Fallback on earlier versions
        }
        
        return true
    }
    
    @available(iOS 9.0, *)
    func application(application: UIApplication, performActionForShortcutItem shortcutItem: UIApplicationShortcutItem, completionHandler: (Bool) -> Void) {
        print("shortcutLaunched")
        self.handleShortcutItem(shortcutItem)
    }
    
    @available(iOS 9.0, *)
    func handleShortcutItem(shortcutIcon: UIApplicationShortcutItem) -> Bool{
        var handled = false
        
        if let shortcutType = ShortcutType.init(rawValue: shortcutIcon.type){
            let rootNavViewController = window!.rootViewController as? UINavigationController
            rootNavViewController?.popToRootViewControllerAnimated(false)
            
            switch shortcutType{
            case .MealShortcut:
                print("case acheived, present meals")
                let tabBar = window?.rootViewController!.childViewControllers[0] as! MyTabBarController
                tabBar.loadMealsTab()
                handled = true
            }
        }
        
        return handled
    }
    
    @available(iOS 9.0, *)
    func session(session: WCSession, didReceiveMessage message: [String : AnyObject], replyHandler: ([String : AnyObject]) -> Void) {
        var replyValue = Dictionary<String, AnyObject>()
        let cachedMenu = NSUserDefaults.standardUserDefaults().dictionaryForKey("savedMenu")
        
        if cachedMenu != nil{
            if message["currentWeekDay"] != nil {
                let currentWeekDay = message["currentWeekDay"] as! String
                let menuDateToDisplayOnWatch = cachedMenu![currentWeekDay] as? NSArray
                if menuDateToDisplayOnWatch != nil || menuDateToDisplayOnWatch!.count != 0 {
                    let watchBreakfast = menuDateToDisplayOnWatch![0].objectForKey("breakfast")
                    let watchLunch = menuDateToDisplayOnWatch![0].objectForKey("lunch")
                    let watchDinner = menuDateToDisplayOnWatch![0].objectForKey("dinner")
                    replyValue["breakfast"] = watchBreakfast
                    replyValue["lunch"] = watchLunch
                    replyValue["dinner"] = watchDinner
                    replyHandler(replyValue)
                }
            }
        }
        else{
            print("Looks like there was nothing saved for this week's menu. :(")
        }
    }
    
    func application(application: UIApplication, didRegisterUserNotificationSettings notificationSettings: UIUserNotificationSettings) {
        UIApplication.sharedApplication().registerForRemoteNotifications()
    }
    
    func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
        var tokenToCompare = deviceToken.description.stringByReplacingOccurrencesOfString("<", withString: "")
        tokenToCompare = tokenToCompare.stringByReplacingOccurrencesOfString(">", withString: "")
        tokenToCompare = tokenToCompare.stringByReplacingOccurrencesOfString(" ", withString: "")
        
        if (NSUserDefaults.standardUserDefaults().boolForKey("didSaveDeviceToken") == false) || (NSUserDefaults.standardUserDefaults().objectForKey("savedDeviceToken") as! String != tokenToCompare){
            Push.uploadDeviceToken(deviceToken.description)
        }
    }
    
    
    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject]) {
        
    }
    
    func application(application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: NSError) {
        print(error.localizedDescription)
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
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}


