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
        self.radialBarImage.setImageNamed("DayCountDown")
        self.radialBarImage.startAnimatingWithImagesInRange(NSMakeRange(0, 100), duration: 86400 * 14.25, repeatCount: 0)
        
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
}
