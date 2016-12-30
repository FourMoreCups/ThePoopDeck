//
//  MealViewController.swift
//  West Point
//
//  Created by Sean on 11/6/14.
//  Copyright (c) 2014 Sean Deaton. All rights reserved.
//

import UIKit

var didAppearCount = 0

//enum UIUserInterfaceIdiom : Int {
//    case Unspecified
//    case Phone // iPhone and iPod touch style UI
//    case Pad // iPad style UI
//}

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
    
    override func viewDidAppear(_ animated: Bool) {
        
        if (didTapOtherView == false){
            didTapOtherView = true
        }
        navigationController?.navigationBar.topItem?.title = "The Meals"
//        if (refreshControl.refreshing == false) && (menu.arrayOfMeals.isEmpty) {
//            self.presentViewController(displayNoMeals(), animated: true, completion: nil)
//        }
        if (isViewLoaded && menu.isEmpty() && !refreshControl.isRefreshing){
            let promptToReloadAlert = UIAlertController(title: "There's nothing here!", message: "Would you like to reload?", preferredStyle: UIAlertControllerStyle.alert)
            promptToReloadAlert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.cancel, handler: nil))
            promptToReloadAlert.addAction(UIAlertAction(title: "Reload", style: UIAlertActionStyle.default, handler: { (UIAlertAction) -> Void in
                self.handleRepeatOfInitialLoadForMeals()
                self.mealTableView.reloadData()
            }))
                
            self.present(promptToReloadAlert, animated: true, completion: nil)
        }
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
    
    func convertDateToString(_ aDate: Date) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateString: String = (dateFormatter.string(from: aDate) as String)
        return dateString
        
    }
    
    //MARK: Table Functions
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return menu.arrayOfMeals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:CustomMealCellTableViewCell = tableView.dequeueReusableCell(withIdentifier: "MealCell") as! CustomMealCellTableViewCell
        let oneMeal = menu.arrayOfMeals[indexPath.row]
        
        
        cell.setCell(oneMeal.dayOfWeek, breakfastLabel: oneMeal.breakfast, lunchLabel: oneMeal.lunch, dinnerLabel: oneMeal.dinner, dateString: oneMeal.dateString)
        return cell
    }
}
