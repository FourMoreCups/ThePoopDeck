//
//  CustomCellTableViewCell.swift
//  Cell Test
//
//  Created by Sean on 10/23/14.
//  Copyright (c) 2014 Sean Deaton. All rights reserved.
//

import UIKit
import QuartzCore
import Foundation

var dayPic: UIImageView = UIImageView()
var pictureArray = ["r1.png", "r2.png", "r3.png", "r4.png"]
var randomIndexOfPictureArray = Int(arc4random_uniform(UInt32(pictureArray.count)))

class CustomCellTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var topDayLabel: UILabel!
    @IBOutlet weak var bottomDayLabel: UILabel!
    @IBOutlet weak var myConentView: UIView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var dayPicture: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        //println("SELECTED")
        // Configure the view for the selected state
    }
    
    func setCell(topLabelText: String, bottomLabelText: String, imageName: String) {
        
        self.topDayLabel.text = topLabelText
        self.bottomDayLabel.text = bottomLabelText
        
        self.mainView.layer.cornerRadius = 0
        self.mainView.layer.masksToBounds = true
        self.mainView.backgroundColor = UIColor.whiteColor()
        self.mainView.alpha = 1.0
        
        dayPicture.image = UIImage(named: imageName)
        
        //        dayPic = UIImageView(image: UIImage(named: imageName))
        //        dayPic.frame = CGRectMake(UIScreen.mainScreen().bounds.width * 0.6, 25, 150, 150)
        //        dayPic.layer.borderWidth = 1
        //        dayPic.layer.borderColor = UIColor.clearColor().CGColor
        //        self.mainView.addSubview(dayPic)
    }
    
    func handleLongPress(){
        
        //dayPic.transform = CGAffineTransformMakeRotation(CGFloat(0.0))
        //println("hi")
        let fullRotation = CGFloat(2*M_PI)
        
        let animation = CAKeyframeAnimation()
        animation.keyPath = "transform.rotation.z"
        animation.duration = 1
        animation.removedOnCompletion = false
        animation.fillMode = kCAFillModeForwards
        animation.repeatCount = Float(1)
        animation.values = [M_PI/16, M_PI/32, 0]
        
        dayPic.layer.addAnimation(animation, forKey: "rotate")
        
        UIView.animateWithDuration(4.0, delay: 1.0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            dayPic.frame = CGRectMake(0, 0, 250, 250)
            }, completion: nil)
        
        
    }
    
    
    
    
    
}

class CustomMealCellTableViewCell: UITableViewCell {
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var breakfastLabel: UILabel!
    @IBOutlet weak var lunchLabel: UILabel!
    @IBOutlet weak var dinnerLabel: UILabel!
    //@IBOutlet weak var randomImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setCell(topLabel: String, breakfastLabel: String, lunchLabel: String, dinnerLabel: String, dateString: String) {
        
        self.topLabel.text = topLabel
        //self.topLabel.font = UIFont(name: "OpenSans", size: 27)
        self.breakfastLabel.text = breakfastLabel
        self.lunchLabel.text = lunchLabel
        self.dinnerLabel.text = dinnerLabel
        
        var dayComponent = dayComponentFromString(dateString)
        
        //randomImage.image = UIImage(named: "r" + String(dayComponent) + ".png")
        
        //        dayPic = UIImageView(image: UIImage(named: "r" + String(dayComponent) + ".png"))
        //
        //        dayPic.layer.anchorPoint = CGPointMake(0.5, 0.5)
        //        dayPic.frame = CGRectMake(UIScreen.mainScreen().bounds.width * 0.60, 30, 150, 150)
        //        self.mainView.addSubview(dayPic)
        
        
        
        
    }
    
    func convertStringToDate(aDateString: String) -> NSDate {
        let dateFormat = NSDateFormatter()
        dateFormat.dateFormat = ("yyyy-MM-dd")
        var newDate = dateFormat.dateFromString(aDateString)
        return newDate!
    }
    
    func dayComponentFromString(dateString: String) -> Int {
        var date = convertStringToDate(dateString)
        //println(date)
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components(NSCalendarUnit.CalendarUnitMonth | NSCalendarUnit.CalendarUnitDay, fromDate: date)
        //println(components.day)
        return components.day
        
    }
    
}





















