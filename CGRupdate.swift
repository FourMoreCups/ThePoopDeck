//
//  CGRupdate.swift
//  The Poop Deck
//
//  Created by Sean Deaton on 2/7/16.
//  Copyright © 2016 Sean Deaton. All rights reserved.
//

import Foundation

class CGRupdate {
    var breakfastUniform: String = ""
    var lunchUniform: String = ""
    var taps: String = ""
    var dateString: String = ""
    var stringToDisplay = ""
    
    init(){
    }
    
    func parseInput(newUpdate: NSArray){
        for obj: AnyObject in newUpdate {
            breakfastUniform = (obj.objectForKey("breakfast")! as! String)
            lunchUniform = (obj.objectForKey("lunch")! as! String)
            taps = obj.objectForKey("taps")! as! String
            dateString = obj.objectForKey("dateString")! as! String
            stringToDisplay = self.labelString()
        }
    }
    
    func labelString() -> String {
        return "The uniform for " + self.dateString + " is " + self.breakfastUniform + ". Taps is at " + self.taps + "."
    }
    
    func updateNotification() -> String{
        let url = "https://seandeaton.com/push/uniformOfTheDay"
        retrieveJSON(url) { (responseObject, error) -> () in
            guard error == nil else {
                NSUserDefaults.standardUserDefaults().setObject(nil, forKey: "pushedUniform")
                hideActivityIndicator()
                return
            }
            let arrayOfUpdates = responseObject!["push"] as! NSArray
            NSUserDefaults.standardUserDefaults().setObject(arrayOfUpdates, forKey: "pushedUniform")
            self.parseInput(arrayOfUpdates)
            hideActivityIndicator()
        }
        if let unwrapArray: NSArray? = NSUserDefaults.standardUserDefaults().objectForKey("pushedUniform") as? NSArray {
            self.parseInput(unwrapArray!)
            self.stringToDisplay = labelString()
            return self.stringToDisplay
        }
        else {
            return "There was an error updating the uniform."
        }
    }
}
