//
//  OvalLayer.swift
//  SBLoader
//
//  Created by Satraj Bambra on 2015-03-19.
//  Copyright (c) 2015 Satraj Bambra. All rights reserved.
//

import UIKit

class OvalLayer: CAShapeLayer {
    
    struct CircleSizes{
        static let circleSmall: Double = 50.0
        static let circleLarge: Double = 150.0
        static let squishAmount: Double = 140.0
    }
  
  let animationDuration: CFTimeInterval = 0.3
  
  override init() {
    super.init()
    fillColor = customYellowColor.CGColor
    path = ovalPathSmall.CGPath
  }
  
  required init(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  var ovalPathSmall: UIBezierPath {
    return UIBezierPath(ovalInRect: CGRect(x: CircleSizes.circleSmall, y: CircleSizes.circleSmall, width: 0.0, height: 0.0))
  }
  
  var ovalPathLarge: UIBezierPath {
    return UIBezierPath(ovalInRect: CGRect(x: 2.5, y: 17.5, width: CircleSizes.circleLarge, height: CircleSizes.circleLarge))
  }
  
  var ovalPathSquishVertical: UIBezierPath {
    return UIBezierPath(ovalInRect: CGRect(x: 2.5, y: 20.0, width: CircleSizes.circleLarge, height: CircleSizes.squishAmount))
  }
  
  var ovalPathSquishHorizontal: UIBezierPath {
    return UIBezierPath(ovalInRect: CGRect(x: 5.0, y: 20.0, width: CircleSizes.squishAmount, height: CircleSizes.squishAmount))
  }
  
  func expand() {
    let expandAnimation: CABasicAnimation = CABasicAnimation(keyPath: "path")
    expandAnimation.fromValue = ovalPathSmall.CGPath
    expandAnimation.toValue = ovalPathLarge.CGPath
    expandAnimation.duration = animationDuration
    expandAnimation.fillMode = kCAFillModeForwards
    expandAnimation.removedOnCompletion = false
    addAnimation(expandAnimation, forKey: nil)
  }
  
  func wobble() {
        let wobbleAnimation1: CABasicAnimation = CABasicAnimation(keyPath: "path")
        wobbleAnimation1.fromValue = ovalPathLarge.CGPath
        wobbleAnimation1.toValue = ovalPathSquishVertical.CGPath
        wobbleAnimation1.beginTime = 0.0
        wobbleAnimation1.duration = animationDuration

        // 2
        let wobbleAnimation2: CABasicAnimation = CABasicAnimation(keyPath: "path")
        wobbleAnimation2.fromValue = ovalPathSquishVertical.CGPath
        wobbleAnimation2.toValue = ovalPathSquishHorizontal.CGPath
        wobbleAnimation2.beginTime = wobbleAnimation1.beginTime + wobbleAnimation1.duration
        wobbleAnimation2.duration = animationDuration

        // 3
        let wobbleAnimation3: CABasicAnimation = CABasicAnimation(keyPath: "path")
        wobbleAnimation3.fromValue = ovalPathSquishHorizontal.CGPath
        wobbleAnimation3.toValue = ovalPathSquishVertical.CGPath
        wobbleAnimation3.beginTime = wobbleAnimation2.beginTime + wobbleAnimation2.duration
        wobbleAnimation3.duration = animationDuration

        // 4
        let wobbleAnimation4: CABasicAnimation = CABasicAnimation(keyPath: "path")
        wobbleAnimation4.fromValue = ovalPathSquishVertical.CGPath
        wobbleAnimation4.toValue = ovalPathLarge.CGPath
        wobbleAnimation4.beginTime = wobbleAnimation3.beginTime + wobbleAnimation3.duration
        wobbleAnimation4.duration = animationDuration

        // 5
        let wobbleAnimationGroup: CAAnimationGroup = CAAnimationGroup()
        wobbleAnimationGroup.animations = [wobbleAnimation1, wobbleAnimation2, wobbleAnimation3,
            wobbleAnimation4]
        wobbleAnimationGroup.duration = wobbleAnimation4.beginTime + wobbleAnimation4.duration
        wobbleAnimationGroup.repeatCount = 1
        addAnimation(wobbleAnimationGroup, forKey: nil)
  }
  
  func contract() {
    
  }
    
    func changeColors(newColor: UIColor){
        
    }
}
