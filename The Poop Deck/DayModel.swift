//
//  DayModel.swift
//  Cell Test
//
//  Created by Sean on 10/23/14.
//  Copyright (c) 2014 Sean Deaton. All rights reserved.
//

import Foundation

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


class Day {
    var dayStringTop = "day"
    var daysLeft = 0
    var imageName = "blank"
    var isFootball = false
    var needsDisplay = true
    
    init(dayStringTop: String, yyyyMMdd: String, imageName: String, isFootball: Bool, needsDisplay: Bool)
    {
        self.dayStringTop = dayStringTop
        self.daysLeft = theDays(yyyyMMdd)
        self.imageName = imageName
        self.isFootball = isFootball
        self.needsDisplay = needsDisplay
    }
}

class Meal {
    
    let breakfast: String
    let lunch: String
    let dinner: String
    let dayOfWeek: String
    let dateString: String
    
    init(breakfast: String, lunch: String, dinner: String, dayOfWeek: String, dateString: String) {
        
        self.breakfast = breakfast
        self.lunch = lunch
        self.dinner = dinner
        self.dayOfWeek = dayOfWeek
        self.dateString = dateString
    }
}
