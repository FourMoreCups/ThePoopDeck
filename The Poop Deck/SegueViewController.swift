//
//  SegueViewController.swift
//  West Point
//
//  Created by Sean on 12/5/14.
//  Copyright (c) 2014 Sean Deaton. All rights reserved.
//

import Foundation
import UIKit

var testLabel = UILabel()

class SegueViewController: UIViewController {
    @IBOutlet weak var originialViewOverlay: UIView!
    @IBOutlet weak var someLabel: UILabel!

    override func viewDidLoad() {

        testLabel.text = "hI"
        testLabel.frame = CGRectMake(0, 0, 50, 100)
        originialViewOverlay.addSubview(testLabel)
        
    }
    
}