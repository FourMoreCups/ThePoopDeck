//
//  RadialBarController.swift
//  The Poop Deck
//
//  Created by Sean Deaton on 5/21/15.
//  Copyright (c) 2015 Sean Deaton. All rights reserved.
//

import WatchKit
//import Foundation

class RadialBarController: WKInterfaceController {
    
    var userGraduatingClass = Graduation()
    
    /*
     * These IBActions match up with the 3D touch menu items in the radial graduation timeline interface.
     * Selecting one of these menu items will invoke a matching function.
     *
     */
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
    @IBAction func select2020() {
        self.userGraduatingClass.classOf = 2020
        self.userGraduatingClass.percentCompletedInt = self.calculatePercentage(self.userGraduatingClass.classOf)
        self.radialAnimation()
    }
    
    /*
     * The actual radial image that is displayed on the watch face.
    */
    @IBOutlet weak var radialBarImage: WKInterfaceImage!
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()

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
    
    /*
     * Depending on which class is input, the function calls theDays on a certain class and their respective R-Day. See below function.
     */
    func calculatePercentage(_ selectedClass: Int)->Double{
        var daysCompleted:Int
        switch selectedClass {
        case 2017:
            daysCompleted = theDays("2013-07-02")
        case 2018:
            daysCompleted = theDays("2014-07-02")
        case 2019:
            daysCompleted = theDays("2015-07-02")
        case 2020:
            daysCompleted = theDays("2016-06-27")
        default:
            daysCompleted = theDays("2013-07-02")
        }
        //print(daysCompleted)
        
        return(Double(abs(daysCompleted))/1424)*100
    }
    
    /*
     * Iterates through a crap load of pictures really fast to make it appear as though the bar is seamlessly moving.
     */
    func radialAnimation(){
        self.radialBarImage.startAnimatingWithImages(in: NSMakeRange(0, Int(self.userGraduatingClass.percentCompletedInt)), duration: 0.7, repeatCount: 1)
    }
    /*
    * theDays is a carry over function from the iPhone Days tableview which computers the number of days since a certain time.
    * The format must be YYYY-MM-DD.
    */
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
