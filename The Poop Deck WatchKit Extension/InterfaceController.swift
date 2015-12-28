////
////  InterfaceController.swift
////  The Poop Deck WatchKit Extension
////
////  Created by Sean Deaton on 5/21/15.
////  Copyright (c) 2015 Sean Deaton. All rights reserved.
////
//
//import WatchKit
//import Foundation
//import WatchConnectivity
//
//
//class InterfaceController: WKInterfaceController, WCSessionDelegate {
//
//    override func awakeWithContext(context: AnyObject?) {
//        super.awakeWithContext(context)
//        
//        // Configure interface objects here.
//    }
//    override func didAppear() {
//        super.didAppear()
//    }
//
//    override func willActivate() {
//        // This method is called when watch view controller is about to be visible to user
//        super.willActivate()
//        
//        let currentDate = NSDate().weekdayName
//        print(currentDate.lowercaseString)
//        //var restoredDict = NSUserDefaults.standardUserDefaults().dictionaryForKey("savedMenu")
//
//        if WCSession.isSupported(){
//            let session = WCSession.defaultSession()
//            session.delegate = self
//            session.activateSession()
//            session.sendMessage(["currentWeekDay": NSDate().weekdayName.lowercaseString], replyHandler: { (response) -> Void in
//                if response["breakfast"] != nil && response["lunch"] != nil && response["dinner"] != nil {
//                    let watchBreakfast  = response["breakfast"] as! String
//                    let watchLunch = response["lunch"] as! String
//                    let watchDinner = response["dinner"] as! String
//                    print(watchBreakfast, watchLunch, watchDinner)
//                }
//
//                }, errorHandler: { (mealFetchError) -> Void in
//                    print(mealFetchError)
//            })
//        }
//
//    }
//
//    override func didDeactivate() {
//        // This method is called when watch view controller is no longer visible
//        super.didDeactivate()
//    }
//    
////    func sendMessageToParentAppWithString(messageText: String) {
////        let infoDictionary = ["message" : messageText]
////        
////        WKInterfaceController.openParentApplication(infoDictionary) {
////            (replyDictionary, error) -> Void in
////            
////            if let castedResponseDictionary = replyDictionary as? [String: String],
////                responseMessage = castedResponseDictionary["message"]
////            {
////                print(responseMessage)
////            }
////        }
////    }
//}
//
