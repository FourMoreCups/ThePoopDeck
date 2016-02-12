//
//  CustomCellTableViewCell.swift
//  Cell Test
//
//  Created by Sean on 10/23/14.
//  Copyright (c) 2014 Sean Deaton. All rights reserved.
//

import UIKit
import Foundation

var dayPic: UIImageView = UIImageView()

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
    }
}

class CustomMealCellTableViewCell: UITableViewCell {
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var breakfastLabel: UILabel!
    @IBOutlet weak var lunchLabel: UILabel!
    @IBOutlet weak var dinnerLabel: UILabel!
    
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
        
        //var dayComponent = dayComponentFromString(dateString)
    }
    
    func convertStringToDate(aDateString: String) -> NSDate {
        let dateFormat = NSDateFormatter()
        dateFormat.dateFormat = ("yyyy-MM-dd")
        let newDate = dateFormat.dateFromString(aDateString)
        return newDate!
    }
    
    func dayComponentFromString(dateString: String) -> Int {
        let date = convertStringToDate(dateString)
        //println(date)
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components([NSCalendarUnit.Month, NSCalendarUnit.Day], fromDate: date)
        //println(components.day)
        return components.day
    }
}

class CustomUniformTableViewCell: UITableViewCell {
    
    @IBOutlet weak var uniformCellLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}





















