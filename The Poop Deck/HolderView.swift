//
//  HolderView.swift
//  SBLoader
//
//  Created by Satraj Bambra on 2015-03-17.
//  Copyright (c) 2015 Satraj Bambra. All rights reserved.
//

import UIKit

protocol HolderViewDelegate:class {
  func animateLabel()
}

class HolderView: UIView {
    
    let ovalLayer = OvalLayer()
    
    var parentFrame: CGRect = CGRect.zero
    weak var delegate:HolderViewDelegate?
      
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.clear
    }
      
    required init(coder: NSCoder) {
        super.init(coder: coder)!
    }
    func addOval() {
        layer.addSublayer(ovalLayer)
        ovalLayer.expand()
    }
    func wobbleOval() {
        ovalLayer.wobble()
    }
    
    func addImageToCenterOfCircle(_ imageToAdd: UIImage){
        //if there is alreay an image in the circle, remove it.
        self.viewWithTag(1)?.removeFromSuperview()
        
        let tankImageView = UIImageView(image: imageToAdd)
        //.bounds is its won coordinate system
        tankImageView.bounds = CGRect(x: 0, y: 0, width: (imageToAdd.size.width), height: (imageToAdd.size.height))
        
        //center the image, adding some random numbers to get it visually centered rather than absolutely.
        tankImageView.frame.origin = CGPoint(x: (self.bounds.size.width - tankImageView.bounds.size.width)/2 + 5, y: (self.bounds.size.height - tankImageView.bounds.size.height)/2 + 12)
        tankImageView.tag = 1
        self.addSubview(tankImageView)
    }
    
}
