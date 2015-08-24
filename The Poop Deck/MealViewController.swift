//
//  MealViewController.swift
//  West Point
//
//  Created by Sean on 11/6/14.
//  Copyright (c) 2014 Sean Deaton. All rights reserved.
//

import UIKit

var didAppearCount = 0

enum UIUserInterfaceIdiom : Int {
    case Unspecified
    case Phone // iPhone and iPod touch style UI
    case Pad // iPad style UI
}

var menu = Menu()

class MealViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var mealTableView: UITableView!
    
    var cellTapped:Bool = true

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addPullToRefreshToTableView(target: self, tableView: mealTableView)
        mealTableView.addSubview(refreshControl)
        showActivityIndicatory(self.view)
        
        //perform everything neccessary to parse the JSON and load the menu to the view, including refreshing the UITableView
        menu.loadMealsIntoMenu(isReloading: false, tableToRefresh: mealTableView)
    }
    
    override func viewDidAppear(animated: Bool) {
        if (didTapOtherView == false){
            didTapOtherView = true
        }
        navigationController?.navigationBar.topItem?.title = "The Meals"
//        if (refreshControl.refreshing == false) && (menu.arrayOfMeals.isEmpty) {
//            self.presentViewController(displayNoMeals(), animated: true, completion: nil)
//        }
        if (isViewLoaded() && menu.isEmpty() && !refreshControl.refreshing){
            var promptToReloadAlert = UIAlertController(title: "There's nothing here!", message: "Would you like to reload?", preferredStyle: UIAlertControllerStyle.Alert)
            promptToReloadAlert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Cancel, handler: nil))
            promptToReloadAlert.addAction(UIAlertAction(title: "Reload", style: UIAlertActionStyle.Default, handler: { (UIAlertAction) -> Void in
                self.handleRepeatOfInitialLoadForMeals()
                self.mealTableView.reloadData()
            }))
                
            self.presentViewController(promptToReloadAlert, animated: true, completion: nil)
        }
        menu.reloadUponAppear()
        self.mealTableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func handleRefreshForMeals(){
        menu.loadMealsIntoMenu(isReloading: true, tableToRefresh: mealTableView)
    }
    
    func handleRepeatOfInitialLoadForMeals(){
        menu.loadMealsIntoMenu(isReloading: false, tableToRefresh: mealTableView)
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
