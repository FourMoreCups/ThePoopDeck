//
//  JSONLoader.swift
//  West Point
//
//  Created by Sean on 11/8/14.
//  Copyright (c) 2014 Sean Deaton. All rights reserved.
//

import Foundation

var arrayOfMeals: [Meal] = [Meal]()
var weekDayArray = ["monday", "tuesday", "wednesday", "thursday", "friday", "saturday", "sunday"]

func retrieveJSON(urlToRequest: String, completionHandler:(responseObject: NSDictionary?, error: NSError?) -> ()) {
    
    let url: NSURL = NSURL(string: urlToRequest)!
    let jsonRequest: NSURLRequest = NSURLRequest(URL: url)
    
    NSURLConnection.sendAsynchronousRequest(jsonRequest, queue: NSOperationQueue.mainQueue()) {
        response, data, error in
            do {
                let jsonResult = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
                print(jsonResult)
                completionHandler(responseObject: jsonResult, error: error)
            }
                
            catch {
                print(error)
            }
            
//        }
    }
}