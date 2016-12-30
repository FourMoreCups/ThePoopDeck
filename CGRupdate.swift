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
    
    func parseInput(_ newUpdate: NSArray){
        for obj in newUpdate {
            breakfastUniform = ((obj as AnyObject).object(forKey: "breakfast")! as! String)
            lunchUniform = ((obj as AnyObject).object(forKey: "lunch")! as! String)
            taps = (obj as AnyObject).object(forKey: "taps")! as! String
            dateString = (obj as AnyObject).object(forKey: "dateString")! as! String
            stringToDisplay = self.labelString()
        }
    }
    
    func checkWhatImageToPlace() -> UIImage {
        let doesContainArmy = self.stringToDisplay.lowercased().range(of: "army")
        let doesContainACU = self.stringToDisplay.lowercased().range(of: "acu")
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
    
    func retrieveJSON(_ urlToRequest: String, completionHandler:@escaping (_ responseObject: NSDictionary?, _ error: NSError?) -> ()) {
        
        let url: URL = URL(string : urlToRequest)!
        let jsonRequest: URLRequest = URLRequest(url: url)
        
        //var jsonResponse: NSURLResponse?
        NSURLConnection.sendAsynchronousRequest(jsonRequest, queue: OperationQueue.main) {
            response, data, error in
            if data == nil {
                completionHandler(nil, error as NSError?)
            } else {
                do {
                    let jsonResult = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
                    completionHandler(jsonResult, error as NSError?)
                    UserDefaults.standard.set(jsonResult, forKey: "pushedUniform")
                }
                catch let error as NSError?{
                    print(error!)
                    completionHandler(nil, error)
                }
            }
        }
    }

    
    func updateNotification() -> String{
        let url = "https://seandeaton.com/push/uniformOfTheDayJSON"
        self.retrieveJSON(url) { (responseObject, error) -> () in
            print(responseObject as Any)
            guard error == nil else {
                //print(error?.description)
                UserDefaults.standard.set(nil, forKey: "pushedUniform")
                UIApplication.shared.keyWindow?.rootViewController?.present(handleAllErrorCodesWithAlerts(error), animated: true, completion: nil)
                hideActivityIndicator()
                return
            }
            let arrayOfUpdates = responseObject!["push"] as! NSArray
            UserDefaults.standard.set(responseObject, forKey: "pushedUniform")
            self.parseInput(arrayOfUpdates)
            hideActivityIndicator()
        }
        //print(NSUserDefaults.standardUserDefaults().objectForKey("pushedUniform") as! NSDictionary)
        //if let unwrapArray = NSUserDefaults.standardUserDefaults().objectForKey("pushedUniform") as? NSArray{
        if (UserDefaults.standard.object(forKey: "pushedUniform") != nil){
            let unwrapAsDict = UserDefaults.standard.object(forKey: "pushedUniform") as! NSDictionary
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
