//
//  MealViewController.swift
//  West Point
//
//  Created by Sean on 11/6/14.
//  Copyright (c) 2014 Sean Deaton. All rights reserved.
//

import UIKit
import Darwin //remove before release

var didAppearCount = 0

var savedMeals: NSUserDefaults = NSUserDefaults(suiteName: "group.com.seandeaton.The-Poop-Deck")!


enum UIUserInterfaceIdiom : Int {
    case Unspecified
    
    case Phone // iPhone and iPod touch style UI
    case Pad // iPad style UI
}

var menu = Menu()

class MealViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var mealTableView: UITableView!
    
    var cellTapped:Bool = true
    var currentRow = 0
    
    //var arrayOfMeals: [Meal] = [Meal]()
    var weekDayArray = ["monday", "tuesday", "wednesday", "thursday", "friday", "saturday", "sunday"]
    
    func update(){
        print(menu.arrayOfMeals)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addPullToRefreshToTableView(target: self, tableView: mealTableView)
        mealTableView.addSubview(refreshControl)
        showActivityIndicatory(self.view)
    
        
        //perform everything neccessary to parse the JSON and load the menu to the view, including refreshing the UITableView
        menu.loadMealsIntoMenu(isReloading: false, tableToRefresh: mealTableView)
    

        self.updateAppGroupForMeals()

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
        println(savedMeals.valueForKey("MealDinner"))
    }
    
    override func viewDidAppear(animated: Bool) {
        if (didTapOtherView == false){
            didTapOtherView = true
        }
        
        navigationController?.navigationBar.topItem?.title = "The Meals"
        if (refreshControl.refreshing == false) && (menu.arrayOfMeals.isEmpty) {
            //self.presentViewController(displayNoMeals(), animated: true, completion: nil)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func handleRefreshForMeals(){
        
        menu.loadMealsIntoMenu(isReloading: true, tableToRefresh: mealTableView)
        self.updateAppGroupForMeals()
    }
    
    func convertDateToString(aDate: NSDate) -> String {
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateString: String = (dateFormatter.stringFromDate(aDate) as String)
        return dateString
        
    }
    
    
    
    //MARK: Table Functions
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return menu.arrayOfMeals.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell:CustomMealCellTableViewCell = tableView.dequeueReusableCellWithIdentifier("MealCell") as! CustomMealCellTableViewCell
        var oneMeal = menu.arrayOfMeals[indexPath.row]
        
        
        cell.setCell(oneMeal.dayOfWeek, breakfastLabel: oneMeal.breakfast, lunchLabel: oneMeal.lunch, dinnerLabel: oneMeal.dinner, dateString: oneMeal.dateString)
        return cell
        
        
        
    }
}
