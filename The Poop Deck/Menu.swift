//
//  Menu.swift
//  The Poop Deck
//
//  Created by Sean Deaton on 7/6/15.
//  Copyright (c) 2015 Sean Deaton. All rights reserved.
//

import Foundation
import UIKit
// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}


var savedMeals: UserDefaults = UserDefaults(suiteName: "group.com.seandeaton.The-Poop-Deck")!

class Menu {
    var weekDayArray = ["monday", "tuesday", "wednesday", "thursday", "friday", "saturday", "sunday"]
    var arrayOfMeals: [Meal] = [Meal]()
    let urlString = ("https://www.seandeaton.com/meals/Meals")
    
    init(){
    }
    
    func empty(){
        self.arrayOfMeals.removeAll(keepingCapacity: false)
    }
    
    func getFirstDay() -> String{
        return self.arrayOfMeals[1].dayOfWeek
    }
    
    func isEmpty() -> Bool{
        return self.arrayOfMeals.isEmpty
    }
    
    func retrieveJSON(_ urlToRequest: String, completionHandler:@escaping (_ responseObject: NSDictionary?, _ error: NSError?) -> ()) {
        
        let url: URL = URL(string : urlToRequest)!
        let jsonRequest: URLRequest = URLRequest(url: url)
        
        //var jsonResponse: NSURLResponse?
        NSURLConnection.sendAsynchronousRequest(jsonRequest, queue: OperationQueue.main) {
            response, data, error in
            print(error)
           if data == nil {
                completionHandler(nil, error as NSError?)
            } else {
                do {
                    let jsonResult = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
                    completionHandler(jsonResult, error as NSError?)
                    UserDefaults.standard.set(jsonResult, forKey: "savedMenu")
                    
                }
                catch let error as NSError?{
                    print(error)
                    completionHandler(nil, error)
                }
            
            }
        }
    }
    
    func loadMealsIntoMenu(isReloading: Bool, tableToRefresh: UITableView) {
        tableToRefresh.isUserInteractionEnabled = false
        refreshControl.beginRefreshing()
        self.retrieveJSON(self.urlString) {
            (responseObject, error) -> () in
    
            if responseObject == nil {
                print(error?.description, terminator: "")
                UIApplication.shared.keyWindow?.rootViewController?.present(handleAllErrorCodesWithAlerts(error), animated: true, completion: nil)
                hideActivityIndicator()
                refreshControl.endRefreshing()
                tableToRefresh.isUserInteractionEnabled = true
                return
            }
            else{
                if(isReloading){
                    self.arrayOfMeals.removeAll(keepingCapacity: false)
                }
                for day in self.weekDayArray{
                    let newResponse: NSArray = responseObject![day] as! NSArray
                    //print(newResponse)
                    for obj: AnyObject in newResponse {
                        let breakfast = (obj.object(forKey: "breakfast")! as! String)
                        let lunch = (obj.object(forKey: "lunch")! as! String)
                        let dinner = obj.object(forKey: "dinner")! as! String
                        let dateString = obj.object(forKey: "dateString")! as! String
                        let dayOfWeek = obj.object(forKey: "dayOfWeek")! as! String
                        let newMeal = Meal(breakfast: breakfast, lunch: lunch, dinner: dinner, dayOfWeek: dayOfWeek, dateString: dateString)
                        if theDays(newMeal.dateString) >= -1 {
                            self.arrayOfMeals.append(newMeal)
                        }
                    }
                }
                self.updateAppGroupForMeals()
                hideActivityIndicator()
                refreshControl.endRefreshing()
                tableToRefresh.isUserInteractionEnabled = true
                tableToRefresh.reloadData()
            }
        }
    }
    
    func reloadUponAppear(){
        
        //TODO: the expression is alwasy true....
        
        //if the app is backgrounded while the day of the week changes
        //this allows the view to refresh the current menu to get rid of the meal yesterday.
        //needs to happen without requiring the user to reload the data from the website
        let day = Date().weekdayName
        if !menu.arrayOfMeals.isEmpty{
            if convertDayToNumerberForSorting(menu.arrayOfMeals[0].dayOfWeek) < convertDayToNumerberForSorting(day){
                menu.arrayOfMeals.remove(at: 0)
            }
        }
    }
    
    fileprivate func convertDayToNumerberForSorting(_ dayOfWeek: String) -> Int?{
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
            dayNum = 0
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
    
//    var writeJSONtoDefaults(jsonString: String){
//    
//    }
    
    func convertStringToDictionary(_ text: String) -> [String:AnyObject]? {
        if let data = text.data(using: String.Encoding.utf8) {
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String:AnyObject]
                return json
            } catch {
                print("Something went wrong")
            }
        }
        return nil
    }
    

}

