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
        self.hidesBottomBarWhenPushed = false
        //self.navigationBar.barTintColor = UIColor(red: 240.0/255.0, green: 240.0/255.0, blue: 240.0/255.0, alpha: 1.0)
        self.navigationBar.setBackgroundImage(nil, for: UIBarMetrics.default)
        self.navigationBar.shadowImage = nil
        
        changeStatusBarAppearance(targetNavigationBar: self.navigationBar)
        addBorder()
    }
    //should probably fix the whole width thing at some point
    func addBorder() {
        let customYellowColor: UIColor = colorWithHexString(hex: "FFC52E")
        let navBorder: UIView = UIView(frame: (CGRect(x: 0, y: navigationBar.frame.size.height-1, width: 2*(navigationBar.frame.size.width), height: 1)))
        navBorder.backgroundColor = customYellowColor
        
        navBorder.isOpaque = true
        navigationBar.addSubview(navBorder)
        navigationBar.clipsToBounds = true
    }
}

class MyTabBarController: UITabBarController {
    override func viewDidLoad(){
        self.hidesBottomBarWhenPushed = false
        self.tabBarController?.tabBar.tintColor = UIColor(red: 240.0, green: 240.0, blue: 240.0, alpha: 1.0)
        addBorderToTabBar()
    }
    
    func loadMealsTab(){
        self.selectedViewController = self.viewControllers![1]
    }
    
    func loadNotificationView(){
        self.selectedViewController = self.viewControllers![2]
    }
    
    func addBorderToTabBar(){
        let navBorder: UIView = UIView(frame: (CGRect(x: 0, y: 0, width: 2*(tabBar.frame.size.width), height: 1)))
        navBorder.backgroundColor = customYellowColor
        tabBar.addSubview(navBorder)
        tabBar.clipsToBounds = true
    }
}

// Creates a UIColor from a Hex string.
func colorWithHexString (hex:String) -> UIColor {
    var cString:String = hex.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines as CharacterSet).uppercased()
    
    if (cString.hasPrefix("#")) {
        cString = cString.substring(from: cString.characters.index(cString.startIndex, offsetBy: 1))
    }
    
    if (cString.characters.count != 6) {
        return UIColor.gray
    }
    
    var rgbValue:UInt32 = 0
    Scanner(string: cString).scanHexInt32(&rgbValue)
    
    return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: CGFloat(1.0)
    )
}

func addImageAboveTableViewController(myTableViewController: UITableView) {
    let logoAboveView = UIImageView(image: UIImage(named: "tarBucket.png"))
    logoAboveView.contentMode = UIViewContentMode.scaleAspectFit
    logoAboveView.layer.anchorPoint = logoAboveView.center
    logoAboveView.frame = CGRect(x: (UIScreen.main.bounds.size.width/2) - 15, y: -75, width: 30, height: 60)
    
    
    myTableViewController.addSubview(logoAboveView)
}

func changeStatusBarAppearance(targetNavigationBar: UINavigationBar) {
    let blockInStatusBarPlace = UIView(frame: CGRect(x: 0, y: -UIApplication.shared.statusBarFrame.height, width: (UIApplication.shared.statusBarFrame.width), height: UIApplication.shared.statusBarFrame.height))
    blockInStatusBarPlace.backgroundColor = UIColor(red: 240.0/250.0, green: 240.0/250.0, blue: 240.0/250.0, alpha: 1.0)
    targetNavigationBar.addSubview(blockInStatusBarPlace)
}
