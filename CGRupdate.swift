//
//  CGRupdate.swift
//  The Poop Deck
//
//  Created by Sean Deaton on 2/7/16.
//  Copyright © 2016 Sean Deaton. All rights reserved.
//

import Foundation
import UIKit

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
    
    func checkWhatImageToPlace() -> UIImage {
        let doesContainArmy = self.stringToDisplay.lowercaseString.rangeOfString("army")
        let doesContainACU = self.stringToDisplay.lowercaseString.rangeOfString("acu")
        /*let doesContainAFC = self.stringToDisplay.lowercaseString.rangeOfString("afc")
        let doesContainAsForClass = self.stringToDisplay.lowercaseString.rangeOfString("class")*/
        
        if (doesContainACU != nil || doesContainArmy != nil){
            return UIImage(named: "tank.png")!
        }
        else/*if (doesContainAFC != nil || doesContainAsForClass != nil)*/ {
            return UIImage(named: "afc.png")!
        }
    }
    
    func labelString() -> String {
        return "The uniform for " + self.dateString + " is " + self.breakfastUniform + ". Taps is at " + self.taps + "."
    }
    
    func retrieveJSON(urlToRequest: String, completionHandler:(responseObject: NSDictionary?, error: NSError?) -> ()) {
        
        let url: NSURL = NSURL(string : urlToRequest)!
        let jsonRequest: NSURLRequest = NSURLRequest(URL: url)
        
        //var jsonResponse: NSURLResponse?
        NSURLConnection.sendAsynchronousRequest(jsonRequest, queue: NSOperationQueue.mainQueue()) {
            response, data, error in
            if data == nil {
                completionHandler(responseObject: nil, error: error)
            } else {
                do {
                    let jsonResult = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
                    completionHandler(responseObject: jsonResult, error: error)
                    NSUserDefaults.standardUserDefaults().setObject(jsonResult, forKey: "pushedUniform")
                }
                catch let error as NSError?{
                    print(error)
                    completionHandler(responseObject: nil, error: error)
                }
            }
        }
    }

    
    func updateNotification() -> String{
        let url = "https://seandeaton.com/push/uniformOfTheDayJSON"
        self.retrieveJSON(url) { (responseObject, error) -> () in
            print(responseObject)
            guard error == nil else {
                //print(error?.description)
                NSUserDefaults.standardUserDefaults().setObject(nil, forKey: "pushedUniform")
                UIApplication.sharedApplication().keyWindow?.rootViewController?.presentViewController(handleAllErrorCodesWithAlerts(error), animated: true, completion: nil)
                hideActivityIndicator()
                return
            }
            let arrayOfUpdates = responseObject!["push"] as! NSArray
            NSUserDefaults.standardUserDefaults().setObject(responseObject, forKey: "pushedUniform")
            self.parseInput(arrayOfUpdates)
            hideActivityIndicator()
        }
        //print(NSUserDefaults.standardUserDefaults().objectForKey("pushedUniform") as! NSDictionary)
        //if let unwrapArray = NSUserDefaults.standardUserDefaults().objectForKey("pushedUniform") as? NSArray{
        if (NSUserDefaults.standardUserDefaults().objectForKey("pushedUniform") != nil){
            let unwrapAsDict = NSUserDefaults.standardUserDefaults().objectForKey("pushedUniform") as! NSDictionary
            let unwrapAsArray = unwrapAsDict["push"] as! NSArray
            self.parseInput(unwrapAsArray)
            return self.stringToDisplay
        }
        else {
            print("cant be unrwapped")
            return "There was an error updating the uniform."
        }
    }
}
