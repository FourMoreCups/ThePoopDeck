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

func retrieveJSON(_ urlToRequest: String, completionHandler:@escaping (_ responseObject: NSDictionary?, _ error: NSError?) -> ()) {
    
    let url: URL = URL(string: urlToRequest)!
    let jsonRequest: URLRequest = URLRequest(url: url)
    
    NSURLConnection.sendAsynchronousRequest(jsonRequest, queue: OperationQueue.main) {
        response, data, error in
            do {
                let jsonResult = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
                print(jsonResult)
                completionHandler(jsonResult, error as NSError?)
            }
                
            catch {
                print(error)
            }
            
//        }
    }
}
