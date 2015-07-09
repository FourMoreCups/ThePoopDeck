//
//  Menu.swift
//  The Poop Deck
//
//  Created by Sean Deaton on 7/6/15.
//  Copyright (c) 2015 Sean Deaton. All rights reserved.
//

import Foundation
import UIKit

var savedMeals: NSUserDefaults = NSUserDefaults(suiteName: "group.com.seandeaton.The-Poop-Deck")!

class Menu {
    var weekDayArray = ["monday", "tuesday", "wednesday", "thursday", "friday", "saturday", "sunday"]
    var arrayOfMeals: [Meal] = [Meal]()
    let urlString = ("http://www.seandeaton.com/meals/Meals")
    
    init(){
    }
    
    func empty(){
        self.arrayOfMeals.removeAll(keepCapacity: false)
    }
    
    func isEmpty() -> Bool{
        return self.arrayOfMeals.isEmpty
    }
    
    func retrieveJSON(urlToRequest: String, completionHandler:(responseObject: NSDictionary?, error: NSError?) -> ()) {
        
        let url: NSURL = NSURL(string : urlToRequest)!
        let jsonRequest: NSURLRequest = NSURLRequest(URL: url)
        
        var jsonResponse: NSURLResponse?
        NSURLConnection.sendAsynchronousRequest(jsonRequest, queue: NSOperationQueue.mainQueue()) {
            response, data, error in
            
            if data == nil {
                completionHandler(responseObject: nil, error: error)
            } else {
                var parseError: NSError?
                let jsonResult = NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers, error: &parseError) as! NSDictionary?
                completionHandler(responseObject: jsonResult, error: error)
            }
        }
    }
    
    func loadMealsIntoMenu(#isReloading: Bool, tableToRefresh: UITableView) {
        tableToRefresh.userInteractionEnabled = false
        refreshControl.beginRefreshing()
        self.retrieveJSON(self.urlString) {
            (responseObject, error) -> () in
    
            if responseObject == nil {
                print(error?.description)
                handleAllErrorCodesWithAlerts(error, self)
                hideActivityIndicator()
                tableToRefresh.userInteractionEnabled = true
                return
            }
            else{
                if(isReloading){
                    self.arrayOfMeals.removeAll(keepCapacity: false)
                }
                for day in self.weekDayArray{
                    var newResponse: NSArray = responseObject![day] as! NSArray
                    for obj: AnyObject in newResponse {
                        var breakfast = (obj.objectForKey("breakfast")! as! String)
                        var lunch = (obj.objectForKey("lunch")! as! String)
                        var dinner = obj.objectForKey("dinner")! as! String
                        let dateString = obj.objectForKey("dateString")! as! String
                        let dayOfWeek = obj.objectForKey("dayOfWeek")! as! String
                        let newMeal = Meal(breakfast: breakfast, lunch: lunch, dinner: dinner, dayOfWeek: dayOfWeek, dateString: dateString)
                        if theDays(newMeal.dateString) >= -1 {
                            self.arrayOfMeals.append(newMeal)
                        }
                    }
                }
                self.updateAppGroupForMeals()
                hideActivityIndicator()
                refreshControl.endRefreshing()
                tableToRefresh.userInteractionEnabled = true
                tableToRefresh.reloadData()
            }
        }
    }
    
    func updateAppGroupForMeals(){
        var savedBreakfast: String
        var savedLunch: String
        var savedDinner: String
        
        if menu.arrayOfMeals.isEmpty {
            savedBreakfast = "No meals"
            savedLunch = "No meals"
            savedDinner = "No meals"
        }
        else{
            savedBreakfast = menu.arrayOfMeals.first!.breakfast
            savedLunch = menu.arrayOfMeals.first!.lunch
            savedDinner = menu.arrayOfMeals.first!.dinner
        }
        
        savedMeals.setValue(savedBreakfast, forKey: "MealBreakfast")
        savedMeals.setValue(savedLunch, forKey: "MealLunch")
        savedMeals.setValue(savedDinner, forKey: "MealDinner")
        //println(savedMeals.valueForKey("MealDinner"))
    }

}

