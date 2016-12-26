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
        let requestedSettings = UIUserNotificationSettings(types: [.sound, .alert, .badge], categories: nil)
        UIApplication.shared.registerUserNotificationSettings(requestedSettings)
        UIApplication.shared.registerForRemoteNotifications()
    }

    static func uploadDeviceToken(_ token: String) -> Bool {
        var tokenToUpload = token.replacingOccurrences(of: "<", with: "")
        tokenToUpload = tokenToUpload.replacingOccurrences(of: ">", with: "")
        tokenToUpload = tokenToUpload.replacingOccurrences(of: " ", with: "")
        
        UserDefaults.standard.set(tokenToUpload, forKey: "savedDeviceToken")
        
        //URL
        let targetDatabase: URL = URL(string: "https://seandeaton.com/push/addDeviceToken.php?token=" + (UserDefaults.standard.object(forKey: "savedDeviceToken") as! String))!
        let urlRequest = URLRequest(url: targetDatabase)
        let queue = OperationQueue()
        
        NSURLConnection.sendAsynchronousRequest(urlRequest, queue: queue) { (responseFromDatabasee, returnedData, errorFromDatabase) -> Void in
            if (errorFromDatabase == nil){
                UserDefaults.standard.set(true, forKey: "didSaveDeviceToken")
            }
            else{
                UserDefaults.standard.set(false, forKey: "didSaveDeviceToken")
            }
        }
        return UserDefaults.standard.bool(forKey: "didSaveDeviceToken")
    }

    func reuploadDeviceTokenUponPreviousFailure() -> Bool {
        let token =  UserDefaults.standard.object(forKey: "savedDeviceToken") as! String
        return Push.uploadDeviceToken(token)
    }
}
