//
//  RadialBarController.swift
//  The Poop Deck
//
//  Created by Sean Deaton on 5/21/15.
//  Copyright (c) 2015 Sean Deaton. All rights reserved.
//

import WatchKit
import Foundation

class RadialBarController: WKInterfaceController {

    @IBOutlet weak var radialBarImage: WKInterfaceImage!
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        var daysCompleted:Int
        
        var userDefaults = NSUserDefaults(suiteName: "group.com.seandeaton.The-Poop-Deck")
        var selectedClass = userDefaults!.integerForKey("class")
        println(selectedClass)
        
        switch selectedClass {
        case 2016:
            daysCompleted = theDays("2012-07-02")
        case 2017:
            daysCompleted = theDays("2013-07-02")
        case 2018:
            daysCompleted = theDays("2014-07-02")
        case 2019:
            daysCompleted = theDays("2015-07-02")
        default:
            daysCompleted = theDays("2012-06-29")
        }
        println(daysCompleted)
        
        var percentCompletedInt = (Double(abs(daysCompleted))/1424)*100
        println(percentCompletedInt)
        
        self.radialBarImage.setImageNamed("DayCountDown")
        self.radialBarImage.startAnimatingWithImagesInRange(NSMakeRange(0, Int(percentCompletedInt)), duration: 0.7, repeatCount: 1)
        
    }
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    func theDays(target: String) -> Int{
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let currentCal = NSCalendar.currentCalendar()
        var todaysDay = dateFormatter.stringFromDate(NSDate())
        
        let startDate: NSDate = dateFormatter.dateFromString(todaysDay)!
        let endDate: NSDate = dateFormatter.dateFromString(target)!
        
        
        let daysLeft = currentCal.components(NSCalendarUnit.CalendarUnitDay, fromDate: startDate, toDate: endDate, options: nil)
        let intDaysLeft = daysLeft.day
        
        //take off one to account for "butts"
        return (intDaysLeft - 1)
        
    }
}
