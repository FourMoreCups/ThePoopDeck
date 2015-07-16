//
//  HUD.swift
//  West Point
//
//  Created by Sean on 11/12/14.
//  Copyright (c) 2014 Sean Deaton. All rights reserved.
//

import Foundation
import UIKit

var container: UIView = UIView()
var actInd: UIActivityIndicatorView = UIActivityIndicatorView()
var loadingView: UIView = UIView()
var isCurrentlySpinning: Bool = false

let spinningImage = UIImageView(image: UIImage(named: "tarBucket.png"))

//Pull To Refresh
var refreshControl = UIRefreshControl()

//No meals to display
var noMealsAlert: UIAlertController = UIAlertController()

//Failure Message
var fetchErrorMessage: UIAlertController = UIAlertController()
var refreshTime: NSTimer = NSTimer()


func addPictureToViewWithAlpha(#targetTableView: UITableView, #imageName: String, #alpha: CGFloat, #contentMode: UIViewContentMode){
    targetTableView.clipsToBounds = true
    targetTableView.backgroundView = UIImageView(image: UIImage(named: imageName))
    targetTableView.backgroundView?.alpha = alpha
    targetTableView.backgroundView?.contentMode = contentMode
}

func showActivityIndicatory(uiView: UIView) {
    
    container.frame = uiView.frame
    container.center = uiView.center
    container.autoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight |
        UIViewAutoresizing.FlexibleLeftMargin | UIViewAutoresizing.FlexibleRightMargin |
        UIViewAutoresizing.FlexibleTopMargin | UIViewAutoresizing.FlexibleBottomMargin
    container.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
    
    //make loadingframe and center it in the superview
    loadingView.frame = CGRectMake(0, 0, 200, 200)
    loadingView.center = container.center
    loadingView.autoresizingMask = (UIViewAutoresizing.FlexibleLeftMargin   |
        UIViewAutoresizing.FlexibleRightMargin  |
        UIViewAutoresizing.FlexibleTopMargin    |
        UIViewAutoresizing.FlexibleBottomMargin)
    loadingView.backgroundColor = UIColor(red: 50, green: 50, blue: 50, alpha: 0.2)
    loadingView.clipsToBounds = true
    loadingView.layer.cornerRadius = 10
    
    spinningImage.alpha = 1
    //actInd.frame = CGRectMake(0.0, 0.0, 40.0, 40.0);
    spinningImage.contentMode = UIViewContentMode.Center
    
    //spinningImage.contentMode = UIViewContentMode.ScaleAspectFit
    
    spinningImage.frame = CGRect()
    spinningImage.center = CGPointMake(loadingView.frame.size.width / 2,
        loadingView.frame.size.height / 2);
    loadingView.addSubview(spinningImage)
    container.addSubview(loadingView)
    uiView.addSubview(container)
    actInd.startAnimating()
    customRefreshImageSpinner()
}

func hideActivityIndicator() {
    container.removeFromSuperview()
    actInd.removeFromSuperview()
    loadingView.removeFromSuperview()
}

func customRefreshImageSpinner() {
    
    let fullRotation = CGFloat(2*M_PI)
    
    let animation = CAKeyframeAnimation()
    animation.keyPath = "transform.rotation.z"
    animation.duration = 1
    animation.removedOnCompletion = false
    animation.fillMode = kCAFillModeForwards
    animation.repeatCount = Float.infinity
    animation.values = [0 ,fullRotation/4, fullRotation/2, fullRotation*3/4, fullRotation]
    
    spinningImage.layer.addAnimation(animation, forKey: "rotate")
    
}

// MARK: Pull to Refresh
func addPullToRefreshToTableView(#target: AnyObject?, #tableView: UITableView) {
    refreshControl.addTarget(target, action: "handleRefreshForMeals", forControlEvents: UIControlEvents.ValueChanged)
    tableView.addSubview(refreshControl)
}

//MARK: Display Faiulure To Refresh Button; Connection Error

func displayMealFetchFailure() ->UIAlertController {
    var message = "We couldn't reach the Mess Hall, try again later."
    fetchErrorMessage = UIAlertController(title: "Oh no!", message: message, preferredStyle: UIAlertControllerStyle.Alert)
    
    fetchErrorMessage.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Cancel, handler: { (dismiss) -> Void in
        println("dismiss")
    }))
    
    return fetchErrorMessage
}

func genericErrorMessageAlertWithDismissButton(title: String, message: String) -> UIAlertController {
    var alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
    alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Cancel, handler: { (dismiss) -> Void in
        print("Dismissed Alert")
    }))
    return alert
}

func handleAllErrorCodesWithAlerts(error: NSError?) -> UIAlertController{
    print(error?.code)
    if (error?.code == NSURLErrorNotConnectedToInternet){
        return genericErrorMessageAlertWithDismissButton("Uh Oh!", "Looks like you don't have signal!")
    }
    if (error?.code == NSURLErrorTimedOut){
        return genericErrorMessageAlertWithDismissButton("Uh Oh!", "The connection timed out. Try again later.")
    }
    else{
        return genericErrorMessageAlertWithDismissButton("Oh oh!", "Something went wrong here...")
    }
}

//MARK: Display No Meals to display; Connection works

func displayNoMeals() -> UIAlertController{
    var message = "Either the meals are not posted this week, or our developers got lazy."
    noMealsAlert = UIAlertController(title: "Whoops!", message: message, preferredStyle: UIAlertControllerStyle.Alert)
    
    noMealsAlert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Cancel, handler: { (action) -> Void in
        println("Dismiss")
    }))
    
    return noMealsAlert
    
}