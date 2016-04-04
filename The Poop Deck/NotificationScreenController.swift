//
//  NotificationScreenController.swift
//  The Poop Deck
//
//  Created by Sean Deaton on 1/31/16.
//  Copyright © 2016 Sean Deaton. All rights reserved.
//

import UIKit

class NotificationScreenController: UIViewController, HolderViewDelegate {
    
    var notificationRefreshControl = UIRefreshControl()
    var holderView = HolderView(frame: CGRectZero)
    var cgrNews = CGRupdate()

    @IBOutlet var notificationView: UIView!
    @IBOutlet weak var uniformLabel: UILabel!
    @IBAction func refreshButton(sender: AnyObject) {
        showActivityIndicatory(self.view)
        self.uniformLabel.text = cgrNews.updateNotification()
        self.holderView.addImageToCenterOfCircle(cgrNews.checkWhatImageToPlace())
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        navigationController?.navigationBar.topItem?.title = "Central Guard Room"
        //self.uniformLabel.text = cgrNews.updateNotification()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        uniformLabel.layer.zPosition = 0
        
        addHolderView()
        holderView.addOval()
        holderView.wobbleOval()
        
        let vertSpaceBetweenLabelAndImage = NSLayoutConstraint(item: self.uniformLabel, attribute: .Top, relatedBy: .Equal, toItem: self.holderView, attribute: .Bottom, multiplier: 1, constant: 35)
        NSLayoutConstraint.activateConstraints([vertSpaceBetweenLabelAndImage])
        
        showActivityIndicatory(self.view)
        
        self.uniformLabel.text = self.cgrNews.updateNotification()
        self.holderView.addImageToCenterOfCircle(cgrNews.checkWhatImageToPlace())
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addHolderView() {
        let boxSize: CGFloat = 150
        holderView.frame = CGRect(x: view.bounds.width / 2 - boxSize / 2,
        y: view.bounds.height / 4 - boxSize / 2,
        width: boxSize,
        height: boxSize)
        holderView.parentFrame = view.frame
        holderView.delegate = self
        holderView.layer.zPosition = 1.0
        view.addSubview(holderView)
    }
    
    func animateLabel() {
        
    }
}

class UniformTableView: UITableView, UITableViewDelegate, UITableViewDataSource {

  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 2
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier("UniformCell")!
        return cell
    }
}

