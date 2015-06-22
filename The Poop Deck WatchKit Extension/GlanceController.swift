//
//  GlanceController.swift
//  The Poop Deck WatchKit Extension
//
//  Created by Sean Deaton on 5/21/15.
//  Copyright (c) 2015 Sean Deaton. All rights reserved.
//

import WatchKit
import Foundation


class GlanceController: WKInterfaceController {

    @IBOutlet weak var imageGroup: WKInterfaceGroup!
    @IBOutlet weak var glanceLabel: WKInterfaceLabel!
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()

        updateMeals()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    func updateMeals() {
        let defaults = NSUserDefaults(suiteName: "group.com.seandeaton.The-Poop-Deck")
        var displayString: String
        var currentHours = NSCalendar.currentCalendar().component(NSCalendarUnit.CalendarUnitHour, fromDate: NSDate())
        
        if currentHours > 19 || currentHours < 8 {
            if (defaults!.stringForKey("MealBreakfast") == nil){
                displayString = "Looks like there's nothing here"
            }
            else {
                displayString = defaults!.stringForKey("MealBreakfast")!
            }
            glanceLabel.setText(String(displayString))
        }
        else if currentHours < 13 && currentHours > 8{
            if (defaults!.stringForKey("MealLunch") == nil){
                displayString = "Looks like there's nothing here"
            }
            else {
                displayString = defaults!.stringForKey("MealLunch")!
            }
            glanceLabel.setText(String(displayString))
        }
        else {
            if (defaults!.stringForKey("MealDinner") == nil){
                displayString = "Looks like there's nothing here"
            }
            else {
                displayString = defaults!.stringForKey("MealDinner")!
            }
            glanceLabel.setText(String(displayString))
        }

    }

    
}
