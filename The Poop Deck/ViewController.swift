//
//  ViewController.swift
//  The Poop Deck
//
//  Created by Sean Deaton on 5/21/15.
//  Copyright (c) 2015 Sean Deaton. All rights reserved.
//

import UIKit

var didTapOtherView: Bool = false

class ViewController: UIViewController {

    @IBOutlet weak var myTableView: UITableView!
    
    var arrayOfDates: [Day] = [Day]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.myTableView.backgroundColor = UIColor.clear
        
        self.setUpDays()
        //adds tarbucket above table. Doesn't currently play nice with different orientations because it's applied statically.
        //addImageAboveTableViewController(myTableViewController: myTableView)
        
        myTableView.reloadData()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.navigationBar.topItem?.title = "The Days"
        myTableView.reloadData()
        
//        if (firstLaunch != true) && (UIDevice.currentDevice().userInterfaceIdiom == .Phone) && (didTapOtherView == false){
//            let alertVC = UIAlertController(title: "Have an Apple Watch?", message: "Stay updated on your progress in the Academy - update your class year in Settings!", preferredStyle: UIAlertControllerStyle.ActionSheet)
//            alertVC.addAction(UIAlertAction(title: "Open Settings", style: .Default) { value in
//                print("tapped default button", terminator: "")
//                UIApplication.sharedApplication().openURL(NSURL(string: UIApplicationOpenSettingsURLString)!)
//                })
//            alertVC.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: { (dismiss) -> Void in
//                print("dismiss", terminator: "")
//            }))
//            self.parentViewController!.presentViewController(alertVC, animated: true, completion: nil)
//            NSUserDefaults.standardUserDefaults().setBool(true, forKey: "FirstLaunch")
//            
//            savedMeals.setValue("Open Meal Tab on iPhone", forKey: "MealBreakfast")
//            savedMeals.setValue("Open Meal Tab on iPhone", forKey: "MealLunch")
//            savedMeals.setValue("Open Meal Tab on iPhone", forKey: "MealDinner")
//        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
     * Adds dates to an array which will populate the table view. 
     * Ensure that you add the cells to the array of potentialCells.
     * We have to check if the number of days left are greater than 0.
    */
    func setUpDays(){
        let rdayCell = Day(dayStringTop: "R-Day", yyyyMMdd: "2015-06-29", imageName: "rdayCircle.png", isFootball: false, needsDisplay: true)
        let ringCell = Day(dayStringTop: "Ring Weekend", yyyyMMdd: "2016-08-26", imageName: "ringCircle.png", isFootball: false, needsDisplay: false)
        let armyNavyCell = Day(dayStringTop: "Army Navy", yyyyMMdd: "2016-12-10", imageName: "armyNavyCircle.png",isFootball: false, needsDisplay: true)
        let christmasCell = Day(dayStringTop: "Christmas Leave", yyyyMMdd: "2016-12-17", imageName: "christmasCircle.png", isFootball: false, needsDisplay: true)
        let fiveCell = Day(dayStringTop: "500th Night", yyyyMMdd: "2017-01-14", imageName: "fiveCircle.png", isFootball: false, needsDisplay: true)
        let yearlingCell = Day(dayStringTop: "Yearling Winter Weekend", yyyyMMdd: "2017-02-04", imageName: "yearlingCircle.png", isFootball: false, needsDisplay: true)
        let hundredCell = Day(dayStringTop: "100th Night", yyyyMMdd: "2017-02-17", imageName: "hundredCircle.png", isFootball: false, needsDisplay: true)
        let springCell = Day(dayStringTop: "Spring Leave", yyyyMMdd: "2017-03-10", imageName: "springCircle.png", isFootball: false, needsDisplay: true)
        let graduationCell = Day(dayStringTop: "Graduation", yyyyMMdd: "2017-05-27", imageName: "gradCircle.png", isFootball: false, needsDisplay: true)
        
        let potentialCells = [rdayCell, ringCell, armyNavyCell, christmasCell, fiveCell, yearlingCell, hundredCell, springCell, graduationCell]
        
        for date in potentialCells {
            if date.daysLeft >= 0 {
                arrayOfDates.append(date)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfDates.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAtIndexPath indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell:CustomCellTableViewCell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! CustomCellTableViewCell
        
        let oneDay = arrayOfDates[indexPath.row]
        var potentialBottomString: String
        
        if oneDay.isFootball {
            potentialBottomString = "\(oneDay.daysLeft) and a butt days until Army plays \(oneDay.dayStringTop) at Miche Stadium."
        }else{
            potentialBottomString = "\(oneDay.daysLeft) and a butt days."
        }
        cell.setCell(oneDay.dayStringTop, bottomLabelText: potentialBottomString, imageName: oneDay.imageName)
        
        cell.backgroundColor = UIColor.clear
        cell.selectionStyle = UITableViewCellSelectionStyle.default
        
        return cell
    }
}

