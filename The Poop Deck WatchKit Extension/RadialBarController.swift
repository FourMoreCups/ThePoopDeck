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
    
    var userGraduatingClass = Graduation()

    @IBAction func select2016() {
        self.userGraduatingClass.classOf = 2016
        self.userGraduatingClass.percentCompletedInt = self.calculatePercentage(self.userGraduatingClass.classOf)
        self.radialAnimation()
    }
    @IBAction func select2017() {
        self.userGraduatingClass.classOf = 2017
        self.userGraduatingClass.percentCompletedInt = self.calculatePercentage(self.userGraduatingClass.classOf)
        self.radialAnimation()
    }
    @IBAction func select2018() {
        self.userGraduatingClass.classOf = 2018
        self.userGraduatingClass.percentCompletedInt = self.calculatePercentage(self.userGraduatingClass.classOf)
        self.radialAnimation()
    }
    @IBAction func select2019() {
        self.userGraduatingClass.classOf = 2019
        self.userGraduatingClass.percentCompletedInt = self.calculatePercentage(self.userGraduatingClass.classOf)
        self.radialAnimation()
    }
    
    
    @IBOutlet weak var radialBarImage: WKInterfaceImage!
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
//        var daysCompleted:Int
//        
//        let userDefaults = NSUserDefaults(suiteName: "group.com.seandeaton.The-Poop-Deck")
//        let selectedClass = userDefaults!.integerForKey("class")
//        print(selectedClass)
//        
//        switch self.userGraduatingClass.classOf {
//        case 2016:
//            daysCompleted = theDays("2012-07-02")
//        case 2017:
//            daysCompleted = theDays("2013-07-02")
//        case 2018:
//            daysCompleted = theDays("2014-07-02")
//        case 2019:
//            daysCompleted = theDays("2015-07-02")
//        default:
//            daysCompleted = theDays("2012-06-29")
//        }
//        print(daysCompleted)
//        
//        self.userGraduatingClass.percentCompletedInt = (Double(abs(daysCompleted))/1424)*100
//        print(self.userGraduatingClass.percentCompletedInt)
        self.userGraduatingClass.percentCompletedInt = self.calculatePercentage(self.userGraduatingClass.classOf)
        self.radialBarImage.setImageNamed("DayCountDown")
    }
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    override func didAppear() {
        super.didAppear()
        self.radialAnimation()
    }
    
    func calculatePercentage(_ selectedClass: Int)->Double{
        var daysCompleted:Int
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
        print(daysCompleted)
        
        return(Double(abs(daysCompleted))/1424)*100

    }
    
    func radialAnimation(){
        self.radialBarImage.startAnimatingWithImages(in: NSMakeRange(0, Int(self.userGraduatingClass.percentCompletedInt)), duration: 0.7, repeatCount: 1)
    }
    
    func theDays(_ target: String) -> Int{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let currentCal = Calendar.current
        let todaysDay = dateFormatter.string(from: Date())
        
        let startDate: Date = dateFormatter.date(from: todaysDay)!
        let endDate: Date = dateFormatter.date(from: target)!
        
        
        let daysLeft = (currentCal as NSCalendar).components(NSCalendar.Unit.day, from: startDate, to: endDate, options: [])
        let intDaysLeft = daysLeft.day
        
        //take off one to account for "butts"
        return (intDaysLeft! - 1)
        
    }
}
