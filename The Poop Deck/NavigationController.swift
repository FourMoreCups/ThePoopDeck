//
//  NavigationContols.swift
//  West Point
//
//  Created by Sean on 11/23/14.
//  Copyright (c) 2014 Sean Deaton. All rights reserved.
//

import Foundation
import UIKit

let customYellowColor: UIColor = colorWithHexString(hex: "FFC52E")

class MainController: UINavigationController {
    
    override func viewDidLoad() {
        //self.navigationBar.barTintColor = UIColor(red: 240.0/255.0, green: 240.0/255.0, blue: 240.0/255.0, alpha: 1.0)
        self.navigationBar.setBackgroundImage(nil, forBarMetrics: UIBarMetrics.Default)
        self.navigationBar.shadowImage = nil
        
        changeStatusBarAppearance(targetNavigationBar: self.navigationBar)
        addBorder()
    }
    //should probably fix the whole width thing at some point
    func addBorder() {
        let customYellowColor: UIColor = colorWithHexString(hex: "FFC52E")
        let navBorder: UIView = UIView(frame: (CGRectMake(0, navigationBar.frame.size.height-1, 2*(navigationBar.frame.size.width), 1)))
        navBorder.backgroundColor = customYellowColor
        
        navBorder.opaque = true
        navigationBar.addSubview(navBorder)
        navigationBar.clipsToBounds = true
    }
}

class MyTabBarController: UITabBarController {
    override func viewDidLoad(){
        self.tabBarController?.tabBar.tintColor = UIColor(red: 240.0, green: 240.0, blue: 240.0, alpha: 1.0)
        addBorderToTabBar()
    }
    
    func addBorderToTabBar(){
        let navBorder: UIView = UIView(frame: (CGRectMake(0, 0, 2*(tabBar.frame.size.width), 1)))
        navBorder.backgroundColor = customYellowColor
        tabBar.addSubview(navBorder)
        tabBar.clipsToBounds = true
    }
}

// Creates a UIColor from a Hex string.
func colorWithHexString (hex hex:String) -> UIColor {
    var cString:String = hex.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet() as NSCharacterSet).uppercaseString
    
    if (cString.hasPrefix("#")) {
        cString = cString.substringFromIndex(cString.startIndex.advancedBy(1))
    }
    
    if (cString.characters.count != 6) {
        return UIColor.grayColor()
    }
    
    var rgbValue:UInt32 = 0
    NSScanner(string: cString).scanHexInt(&rgbValue)
    
    return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: CGFloat(1.0)
    )
}

func addImageAboveTableViewController(myTableViewController myTableViewController: UITableView) {
    let logoAboveView = UIImageView(image: UIImage(named: "tarBucket.png"))
    logoAboveView.contentMode = UIViewContentMode.ScaleAspectFit
    logoAboveView.layer.anchorPoint = logoAboveView.center
    logoAboveView.frame = CGRectMake((UIScreen.mainScreen().bounds.size.width/2) - 15, -75, 30, 60)
    
    
    myTableViewController.addSubview(logoAboveView)
}

func changeStatusBarAppearance(targetNavigationBar targetNavigationBar: UINavigationBar) {
    let blockInStatusBarPlace = UIView(frame: CGRectMake(0, -UIApplication.sharedApplication().statusBarFrame.height, (UIApplication.sharedApplication().statusBarFrame.width), UIApplication.sharedApplication().statusBarFrame.height))
    blockInStatusBarPlace.backgroundColor = UIColor(red: 240.0/250.0, green: 240.0/250.0, blue: 240.0/250.0, alpha: 1.0)
    targetNavigationBar.addSubview(blockInStatusBarPlace)
}