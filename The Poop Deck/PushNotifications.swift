//
//  PushNotifications.swift
//  The Poop Deck
//
//  Created by Sean Deaton on 1/27/16.
//  Copyright © 2016 Sean Deaton. All rights reserved.
//

import Foundation
import UIKit

struct Push {
    static func initializeNotificationServices(){
        let requestedSettings = UIUserNotificationSettings(forTypes: [.Sound, .Alert, .Badge], categories: nil)
        UIApplication.sharedApplication().registerUserNotificationSettings(requestedSettings)
        UIApplication.sharedApplication().registerForRemoteNotifications()
    }

    static func uploadDeviceToken(token: String) -> Bool {
        var tokenToUpload = token.stringByReplacingOccurrencesOfString("<", withString: "")
        tokenToUpload = tokenToUpload.stringByReplacingOccurrencesOfString(">", withString: "")
        tokenToUpload = tokenToUpload.stringByReplacingOccurrencesOfString(" ", withString: "")
        
        NSUserDefaults.standardUserDefaults().setObject(tokenToUpload, forKey: "savedDeviceToken")
        
        //URL
        let targetDatabase: NSURL = NSURL(string: "https://seandeaton.com/push/addDeviceToken.php?token=" + (NSUserDefaults.standardUserDefaults().objectForKey("savedDeviceToken") as! String))!
        let urlRequest = NSURLRequest(URL: targetDatabase)
        let queue = NSOperationQueue()
        
        NSURLConnection.sendAsynchronousRequest(urlRequest, queue: queue) { (responseFromDatabasee, returnedData, errorFromDatabase) -> Void in
            if (errorFromDatabase == nil){
                NSUserDefaults.standardUserDefaults().setBool(true, forKey: "didSaveDeviceToken")
            }
            else{
                NSUserDefaults.standardUserDefaults().setBool(false, forKey: "didSaveDeviceToken")
            }
        }
        return NSUserDefaults.standardUserDefaults().boolForKey("didSaveDeviceToken")
    }

    func reuploadDeviceTokenUponPreviousFailure() -> Bool {
        let token =  NSUserDefaults.standardUserDefaults().objectForKey("savedDeviceToken") as! String
        return Push.uploadDeviceToken(token)
    }
}