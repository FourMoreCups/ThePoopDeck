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

let spinningImage = UIImageView(image: UIImage(named: "spinningImage.png"))

//Pull To Refresh
var refreshControl = UIRefreshControl()

//No meals to display
var noMealsAlert: UIAlertController = UIAlertController()

//Failure Message
var fetchErrorMessage: UIAlertController = UIAlertController()
var refreshTime: Timer = Timer()


func addPictureToViewWithAlpha(targetTableView: UITableView, imageName: String, alpha: CGFloat, contentMode: UIViewContentMode){
    targetTableView.clipsToBounds = true
    targetTableView.backgroundView = UIImageView(image: UIImage(named: imageName))
    targetTableView.backgroundView?.alpha = alpha
    targetTableView.backgroundView?.contentMode = contentMode
}

func showActivityIndicatory(_ uiView: UIView) {
    
    container.frame = uiView.frame
    container.center = uiView.center
    container.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight, UIViewAutoresizing.flexibleLeftMargin, UIViewAutoresizing.flexibleRightMargin, UIViewAutoresizing.flexibleTopMargin, UIViewAutoresizing.flexibleBottomMargin]
    container.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
    
    //make loadingframe and center it in the superview
    loadingView.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
    loadingView.center = container.center
    loadingView.autoresizingMask = ([UIViewAutoresizing.flexibleLeftMargin, UIViewAutoresizing.flexibleRightMargin, UIViewAutoresizing.flexibleTopMargin, UIViewAutoresizing.flexibleBottomMargin])
    loadingView.backgroundColor = UIColor(red: 50, green: 50, blue: 50, alpha: 0.2)
    loadingView.clipsToBounds = true
    loadingView.layer.cornerRadius = 10
    
    spinningImage.alpha = 1
    //actInd.frame = CGRectMake(0.0, 0.0, 40.0, 40.0);
    spinningImage.contentMode = UIViewContentMode.center
    
    //spinningImage.contentMode = UIViewContentMode.ScaleAspectFit
    
    spinningImage.frame = CGRect()
    spinningImage.center = CGPoint(x: loadingView.frame.size.width / 2,
        y: loadingView.frame.size.height / 2);
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
    animation.isRemovedOnCompletion = false
    animation.fillMode = kCAFillModeForwards
    animation.repeatCount = Float.infinity
    animation.values = [0 ,fullRotation/4, fullRotation/2, fullRotation*3/4, fullRotation]
    
    spinningImage.layer.add(animation, forKey: "rotate")
    
}

// MARK: Pull to Refresh
func addPullToRefreshToTableView(target: AnyObject?, tableView: UITableView) {
    refreshControl.addTarget(target, action: Selector(("handleRefreshForMeals")), for: UIControlEvents.valueChanged)
    tableView.addSubview(refreshControl)
}

//MARK: Display Faiulure To Refresh Button; Connection Error

func displayMealFetchFailure() ->UIAlertController {
    let message = "We couldn't reach the Mess Hall, try again later."
    fetchErrorMessage = UIAlertController(title: "Oh no!", message: message, preferredStyle: UIAlertControllerStyle.alert)
    
    fetchErrorMessage.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.cancel, handler: { (dismiss) -> Void in
        print("dismiss")
    }))
    
    return fetchErrorMessage
}

func genericErrorMessageAlertWithDismissButton(_ title: String, message: String) -> UIAlertController {
    let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
    alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.cancel, handler: { (dismiss) -> Void in
        print("Dismissed Alert", terminator: "")
    }))
    return alert
}

func handleAllErrorCodesWithAlerts(_ error: NSError?) -> UIAlertController{
    print(error!.code, terminator: "")
    if (error?.code == NSURLErrorNotConnectedToInternet){
        return genericErrorMessageAlertWithDismissButton("Uh Oh!", message: "Looks like you don't have signal!")
    }
    if (error?.code == NSURLErrorTimedOut){
        return genericErrorMessageAlertWithDismissButton("Uh Oh!", message: "The connection timed out. Try again later.")
    }
    else{
        return genericErrorMessageAlertWithDismissButton("Oh oh!", message: "Something went wrong here...")
    }
}

//MARK: Display No Meals to display; Connection works

func displayNoMeals() -> UIAlertController{
    let message = "Either the meals are not posted this week, or our developers got lazy."
    noMealsAlert = UIAlertController(title: "Whoops!", message: message, preferredStyle: UIAlertControllerStyle.alert)
    
    noMealsAlert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.cancel, handler: { (action) -> Void in
        print("Dismiss")
    }))
    
    return noMealsAlert
    
}
