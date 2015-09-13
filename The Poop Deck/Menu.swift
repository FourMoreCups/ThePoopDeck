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
    
    func getFirstDay() -> String{
        return self.arrayOfMeals[1].dayOfWeek
    }
    
    func isEmpty() -> Bool{
        return self.arrayOfMeals.isEmpty
    }
    
    func retrieveJSON(urlToRequest: String, completionHandler:(responseObject: NSDictionary?, error: NSError?) -> ()) {
        
        let url: NSURL = NSURL(string : urlToRequest)!
        let jsonRequest: NSURLRequest = NSURLRequest(URL: url)
        
        //var jsonResponse: NSURLResponse?
        NSURLConnection.sendAsynchronousRequest(jsonRequest, queue: NSOperationQueue.mainQueue()) {
            response, data, error in
            print(error)
//            if data == nil {
//                completionHandler(responseObject: nil, error: error)
//            } else {
//                var parseError: NSError?
//                let jsonResult = NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers) as! NSDictionary?
//                completionHandler(responseObject: jsonResult, error: error)
                
                do {
                    let jsonResult = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
                    completionHandler(responseObject: jsonResult, error: error)
                }
                
                catch {
                    print(error)
                }
            
 //           }
        }
    }
    
    func loadMealsIntoMenu(isReloading isReloading: Bool, tableToRefresh: UITableView) {
        tableToRefresh.userInteractionEnabled = false
        refreshControl.beginRefreshing()
        self.retrieveJSON(self.urlString) {
            (responseObject, error) -> () in
    
            if responseObject == nil {
                print(error?.description, terminator: "")
                UIApplication.sharedApplication().keyWindow?.rootViewController?.presentViewController(handleAllErrorCodesWithAlerts(error), animated: true, completion: nil)
                hideActivityIndicator()
                refreshControl.endRefreshing()
                tableToRefresh.userInteractionEnabled = true
                return
            }
            else{
                if(isReloading){
                    self.arrayOfMeals.removeAll(keepCapacity: false)
                }
                for day in self.weekDayArray{
                    let newResponse: NSArray = responseObject![day] as! NSArray
                    for obj: AnyObject in newResponse {
                        let breakfast = (obj.objectForKey("breakfast")! as! String)
                        let lunch = (obj.objectForKey("lunch")! as! String)
                        let dinner = obj.objectForKey("dinner")! as! String
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
    
    func reloadUponAppear(){
        //if the app is backgrounded while the day of the week changes
        //this allows the view to refresh the current menu to get rid of the meal yesterday.
        //needs to happen without requiring the user to reload the data from the website
        let day = NSDate().weekdayName
        if !menu.arrayOfMeals.isEmpty{
            if convertDayToNumerberForSorting(menu.arrayOfMeals[0].dayOfWeek) < convertDayToNumerberForSorting(day){
                menu.arrayOfMeals.removeAtIndex(0)
            }
        }
    }
    
    private func convertDayToNumerberForSorting(dayOfWeek: String) -> Int?{
        var dayNum: Int?
        switch dayOfWeek{
        case "Sunday":
            dayNum = 1
        case "Monday":
            dayNum = 2
        case "Tuesday":
            dayNum = 3
        case "Wednesday":
            dayNum = 4
        case "Thursday":
            dayNum = 5
        case "Friday":
            dayNum = 6
        case "Saturday":
            dayNum = 7
        case "PSA":
            dayNum = 8
        default:
            dayNum = 8
        }
        return dayNum
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

