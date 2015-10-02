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
    //var backgroundTaskIdentifier = UIBackgroundTaskIdentifier()
    
    let firstLaunch = NSUserDefaults.standardUserDefaults().boolForKey("FirstLaunch")

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.myTableView.backgroundColor = UIColor.clearColor()
        
        self.setUpDays()
        addImageAboveTableViewController(myTableViewController: myTableView)
        
        myTableView.reloadData()
        
        //BACKGROUND EXECUTION for Apple Watch in iOS9
//        backgroundTaskIdentifier = UIApplication.sharedApplication().beginBackgroundTaskWithExpirationHandler({ () -> Void in
//            UIApplication.sharedApplication().endBackgroundTask(self.backgroundTaskIdentifier)
//        })
//        var timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "update", userInfo: nil, repeats: true)
        
    }
    
//    func update(){
//
//    }
    
    override func viewDidAppear(animated: Bool) {
        navigationController?.navigationBar.topItem?.title = "The Days"
        myTableView.reloadData()
        
        if (firstLaunch != true) && (UIDevice.currentDevice().userInterfaceIdiom == .Phone) && (didTapOtherView == false){
            let alertVC = UIAlertController(title: "Have an Apple Watch?", message: "Stay updated on your progress in the Academy - update your class year in Settings!", preferredStyle: UIAlertControllerStyle.ActionSheet)
            alertVC.addAction(UIAlertAction(title: "Open Settings", style: .Default) { value in
                print("tapped default button", terminator: "")
                UIApplication.sharedApplication().openURL(NSURL(string: UIApplicationOpenSettingsURLString)!)
                })
            alertVC.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: { (dismiss) -> Void in
                print("dismiss", terminator: "")
            }))
            self.parentViewController!.presentViewController(alertVC, animated: true, completion: nil)
            NSUserDefaults.standardUserDefaults().setBool(true, forKey: "FirstLaunch")
            
            savedMeals.setValue("Open Meal Tab on iPhone", forKey: "MealBreakfast")
            savedMeals.setValue("Open Meal Tab on iPhone", forKey: "MealLunch")
            savedMeals.setValue("Open Meal Tab on iPhone", forKey: "MealDinner")
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setUpDays(){
        let rdayCell = Day(dayStringTop: "R-Day", yyyyMMdd: "2015-06-29", imageName: "rdayCircle.png", isFootball: false, needsDisplay: true)
        let ringCell = Day(dayStringTop: "Ring Weekend", yyyyMMdd: "2015-08-28", imageName: "ringCircle.png", isFootball: false, needsDisplay: false)
        //        var buffaloCell = Day(dayStringTop: "Fordham", yyyyMMdd: "2014-09-06", imageName: "firstieRing.png", isFootball: true, needsDisplay: false)
        //        var wakeForestCell = Day(dayStringTop: "Wake Forest", yyyyMMdd: "2014-09-20", imageName: "firstieRing.png", isFootball: true, needsDisplay: false)
        //        var ballStateCell = Day(dayStringTop: "Ball State", yyyyMMdd: "2014-10-04", imageName: "firstieRing.png", isFootball: true, needsDisplay: false)
        //        var riceCell = Day(dayStringTop: "Rice", yyyyMMdd: "2014-10-11", imageName: "firstieRing.png", isFootball: true, needsDisplay: false)
        //        var airForceCell = Day(dayStringTop: "Air Force", yyyyMMdd: "2014-11-01", imageName: "airForcePic.png", isFootball: true, needsDisplay: true)
        //        var fordhamCell = Day(dayStringTop: "Fordham", yyyyMMdd: "2014-11-22", imageName: "fordham.png", isFootball: true, needsDisplay: true)
        let armyNavyCell = Day(dayStringTop: "Army Navy", yyyyMMdd: "2015-12-12", imageName: "armyNavyCircle.png",isFootball: false, needsDisplay: true)
        let christmasCell = Day(dayStringTop: "Christmas Leave", yyyyMMdd: "2015-12-19", imageName: "christmasCircle.png", isFootball: false, needsDisplay: true)
        let fiveCell = Day(dayStringTop: "500th Night", yyyyMMdd: "2016-01-30", imageName: "fiveCircle.png", isFootball: false, needsDisplay: true)
        let yearlingCell = Day(dayStringTop: "Yearling Winter Weekend", yyyyMMdd: "2016-02-06", imageName: "yearlingCircle.png", isFootball: false, needsDisplay: true)
        let hundredCell = Day(dayStringTop: "100th Night", yyyyMMdd: "2016-02-19", imageName: "hundredCircle.png", isFootball: false, needsDisplay: true)
        let springCell = Day(dayStringTop: "Spring Leave", yyyyMMdd: "2016-03-11", imageName: "springCircle.png", isFootball: false, needsDisplay: true)
        let graduationCell = Day(dayStringTop: "Graduation", yyyyMMdd: "2016-05-21", imageName: "gradCircle.png", isFootball: false, needsDisplay: true)
        
        
        let potentialCells = [rdayCell, ringCell, armyNavyCell, christmasCell, fiveCell, yearlingCell, hundredCell, springCell, graduationCell]
        
        for date in potentialCells {
            if date.daysLeft >= 0 {
                arrayOfDates.append(date)
            }
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfDates.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        let cell:CustomCellTableViewCell = tableView.dequeueReusableCellWithIdentifier("Cell") as! CustomCellTableViewCell
        
        let oneDay = arrayOfDates[indexPath.row]
        var potentialBottomString: String
        
        if oneDay.isFootball {
            potentialBottomString = "\(oneDay.daysLeft) and a butt days until Army plays \(oneDay.dayStringTop) at Miche Stadium."
        }else{
            potentialBottomString = "\(oneDay.daysLeft) and a butt days."
        }
        cell.setCell(oneDay.dayStringTop, bottomLabelText: potentialBottomString, imageName: oneDay.imageName)
        
        cell.backgroundColor = UIColor.clearColor()
        cell.selectionStyle = UITableViewCellSelectionStyle.Default
        
        return cell
    }
}

