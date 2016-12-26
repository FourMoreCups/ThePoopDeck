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
        case NotificationShortcute = "com.seandeaton.The-Poop-Deck.notificationshortcut"
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        //check for shortcut item
        
        Push.initializeNotificationServices()
        
        if #available(iOS 9.0, *) {
            if let shortcutItem = launchOptions?[UIApplicationLaunchOptionsKey.shortcutItem] as! UIApplicationShortcutItem?{
                self.handleShortcutItem(shortcutItem)
            }
        } else {
            // Fallback on earlier versions
        }
        
        if #available(iOS 9.0, *) {
            if WCSession.isSupported() {
                let session = WCSession.default()
                session.delegate = self
                session.activate()
                
                if session.isPaired != true {
                    print("Apple Watch not paired")
                }
                if session.isWatchAppInstalled != true {
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
    func application(_ application: UIApplication, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
        print("shortcutLaunched")
        self.handleShortcutItem(shortcutItem)
    }
    
    @available(iOS 9.0, *)
    func handleShortcutItem(_ shortcutIcon: UIApplicationShortcutItem) -> Bool{
        var handled = false
        
        if let shortcutType = ShortcutType.init(rawValue: shortcutIcon.type){
            let rootNavViewController = window!.rootViewController as? UINavigationController
            rootNavViewController?.popToRootViewController(animated: false)
            
            switch shortcutType{
            case .MealShortcut:
                print("case acheived, present meals")
                let tabBar = window?.rootViewController!.childViewControllers[0] as! MyTabBarController
                tabBar.loadMealsTab()
                handled = true
            case .NotificationShortcute:
                print("Here are the notifications!")
                let tabBar = window?.rootViewController!.childViewControllers[0] as! MyTabBarController
                tabBar.loadNotificationView()
                handled = true

            }
        }
        
        return handled
    }
    
    @available(iOS 9.0, *)
    func session(_ session: WCSession, didReceiveMessage message: [String : Any], replyHandler: @escaping ([String : Any]) -> Void) {
        var replyValue = Dictionary<String, AnyObject>()
        let cachedMenu = UserDefaults.standard.dictionary(forKey: "savedMenu")
        
        if cachedMenu != nil{
            if message["currentWeekDay"] != nil {
                let currentWeekDay = message["currentWeekDay"] as! String
                let menuDateToDisplayOnWatch = cachedMenu![currentWeekDay] as? NSArray
                if menuDateToDisplayOnWatch != nil || menuDateToDisplayOnWatch!.count != 0 {
                    let watchBreakfast = (menuDateToDisplayOnWatch![0] as AnyObject).object(forKey: "breakfast")
                    let watchLunch = (menuDateToDisplayOnWatch![0] as AnyObject).object(forKey: "lunch")
                    let watchDinner = (menuDateToDisplayOnWatch![0] as AnyObject).object(forKey: "dinner")
                    replyValue["breakfast"] = watchBreakfast as AnyObject?
                    replyValue["lunch"] = watchLunch as AnyObject?
                    replyValue["dinner"] = watchDinner as AnyObject?
                    replyHandler(replyValue)
                }
            }
        }
        else{
            print("Looks like there was nothing saved for this week's menu. :(")
        }
    }
    
    func application(_ application: UIApplication, didRegister notificationSettings: UIUserNotificationSettings) {
        UIApplication.shared.registerForRemoteNotifications()
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        var tokenToCompare = deviceToken.description.replacingOccurrences(of: "<", with: "")
        tokenToCompare = tokenToCompare.replacingOccurrences(of: ">", with: "")
        tokenToCompare = tokenToCompare.replacingOccurrences(of: " ", with: "")
        
        if (UserDefaults.standard.bool(forKey: "didSaveDeviceToken") == false) || (UserDefaults.standard.object(forKey: "savedDeviceToken") as! String != tokenToCompare){
            Push.uploadDeviceToken(deviceToken.description)
        }
    }
    
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
        
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print(error.localizedDescription)
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
                
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}


