//
//  InterfaceController.swift
//  The Poop Deck WatchKit Extension
//
//  Created by Sean Deaton on 5/21/15.
//  Copyright (c) 2015 Sean Deaton. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {

    @IBOutlet weak var mealLabel: WKInterfaceLabel!
    @IBAction func refreshButton() {
        updateMeals()
    }
 
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
    
    func sendMessageToParentAppWithString(messageText: String) {
        let infoDictionary = ["message" : messageText]
        
        WKInterfaceController.openParentApplication(infoDictionary) {
            (replyDictionary, error) -> Void in
            
            if let castedResponseDictionary = replyDictionary as? [String: String],
                responseMessage = castedResponseDictionary["message"]
            {
                println(responseMessage)
            }
        }
    }
    
    func updateMeals() {
        sendMessageToParentAppWithString("Refreshed")
        let defaults = NSUserDefaults(suiteName: "group.com.seandeaton.The-Poop-Deck")
        var displayString: String
        var currentHours = NSCalendar.currentCalendar().component(NSCalendarUnit.CalendarUnitHour, fromDate: NSDate())
        
        if currentHours > 19 || currentHours < 8 {
            if (defaults!.stringForKey("MealBreakfast") != nil){
                displayString = defaults!.stringForKey("MealBreakfast")!
                mealLabel.setText(String(displayString))
            }
            else{
            mealLabel.setText(String("Open The Meals on iPhone"))
            }
        }
        else if currentHours < 13 && currentHours > 8{
            if (defaults!.stringForKey("MealLunch") != nil){
                displayString = defaults!.stringForKey("MealLunch")!
                mealLabel.setText(String(displayString))
            }
            else{
                mealLabel.setText("Open The Meals on iPhone")
            }
        }
        else {
            if (defaults!.stringForKey("MealDinner") != nil){
                displayString = defaults!.stringForKey("MealDinner")!
                mealLabel.setText(String(displayString))
            }
            else{
                mealLabel.setText("Open The Meals on iPhone")
            }
        }
    }


}

