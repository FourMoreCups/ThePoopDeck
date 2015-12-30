//
//  WatchMenuInterface.swift
//  The Poop Deck
//
//  Created by Sean Deaton on 12/24/15.
//  Copyright © 2015 Sean Deaton. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity

class WatchMenuInterfaceController: WKInterfaceController, WCSessionDelegate {
    @IBOutlet var menu: WKInterfaceTable!
    var watchMenuDataBase = WatchMenu()
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        menu.setNumberOfRows(3, withRowType: "WatchMenuRow")

    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
        let currentDate = NSDate().weekdayName
        print(currentDate.lowercaseString)
        //var restoredDict = NSUserDefaults.standardUserDefaults().dictionaryForKey("savedMenu")
        
        if #available(iOS 9.0, *) {
            let session = WCSession.defaultSession()
            session.delegate = self
            session.activateSession()
            if session.reachable{
                print("reachable!")
                session.sendMessage(["currentWeekDay": NSDate().weekdayName.lowercaseString], replyHandler: { (response) -> Void in
                    if response["breakfast"] != nil && response["lunch"] != nil && response["dinner"] != nil {
                        self.watchMenuDataBase.mealDictionary["breakfast"] = (response["breakfast"] as? String)?.componentsSeparatedByString("&")[0]
                        self.watchMenuDataBase.mealDictionary["lunch"] = (response["lunch"] as? String)?.componentsSeparatedByString("&")[0]
                        self.watchMenuDataBase.mealDictionary["dinner"] = (response["dinner"] as? String)?.componentsSeparatedByString("&")[0]
                        self.loadTable()
                    }
                    
                    }, errorHandler: { (mealFetchError) -> Void in
                        self.watchMenuDataBase.mealDictionary["breakfast"]="Here's a nondescript error."
                        self.watchMenuDataBase.mealDictionary["lunch"] = "Try refreshing on your phone!"
                        self.watchMenuDataBase.mealDictionary["dinner"] = "Otherwise, contact x74803."
                        self.loadTable()
                        print(mealFetchError)
                })
            }
            else{
                if session.iOSDeviceNeedsUnlockAfterRebootForReachability{
                    self.watchMenuDataBase.mealDictionary["breakfast"]="Your device is paired."
                    self.watchMenuDataBase.mealDictionary["lunch"] = "You also recently restarted your iPhone."
                    self.watchMenuDataBase.mealDictionary["dinner"] = "You will need to unlock your iPhone to continue."
                    self.loadTable()
                }
                else{
                //Not reachable
                    self.watchMenuDataBase.mealDictionary["breakfast"]="Can't seem to pair with phone."
                    self.watchMenuDataBase.mealDictionary["lunch"] = "Try again when in range."
                    self.watchMenuDataBase.mealDictionary["dinner"] = "Otherwise, contact x74803."
                    self.loadTable()
                }
            }
        }
        else{
          //This is not iOS 9+
        }
    }

    
    override func didDeactivate() {
        super.didDeactivate()
    }
    
    func loadTable(){
        for cell in 0...menu.numberOfRows-1{
            let row = menu.rowControllerAtIndex(cell) as! WatchMenuRow
            
            switch cell{
            case 0:
                row.menuLabel.setText(self.watchMenuDataBase.mealDictionary["breakfast"])
            case 1:
                row.menuLabel.setText(self.watchMenuDataBase.mealDictionary["lunch"])
            case 2:
                row.menuLabel.setText(self.watchMenuDataBase.mealDictionary["dinner"])
            default:
                row.menuLabel.setText("Hmm..Something's wrong!")
            }
        }
    }
}
