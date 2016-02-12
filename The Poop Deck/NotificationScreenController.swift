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
        cgrNews.updateNotification()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        navigationController?.navigationBar.topItem?.title = "Central Guard Room"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addHolderView()
        holderView.addOval()
        holderView.wobbleOval()
        
        //notificationView.addSubview(refreshControl)
        showActivityIndicatory(self.view)
        
        
        self.uniformLabel.text = self.cgrNews.updateNotification()
//        let url = "https://seandeaton.com/push/uniformOfTheDay"
//        retrieveJSON(url) { (responseObject, error) -> () in
//            guard error == nil else {
//                NSUserDefaults.standardUserDefaults().setObject(nil, forKey: "pushedUniform")
//                self.uniformLabel.text = "There was an error updating the duty uniform."
//                self.notificationRefreshControl.endRefreshing()
//                hideActivityIndicator()
//                return
//            }
//            let arrayOfUpdates = responseObject!["push"] as! NSArray
//            NSUserDefaults.standardUserDefaults().setObject(arrayOfUpdates, forKey: "pushedUniform")
//            self.cgrNews.parseInput(arrayOfUpdates)
//            print(self.cgrNews.breakfastUniform)
//            self.uniformLabel.text = self.cgrNews.labelString()
//            self.notificationRefreshControl.endRefreshing()
//            hideActivityIndicator()
//        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func addHolderView() {
        let boxSize: CGFloat = 150
        holderView.frame = CGRect(x: view.bounds.width / 2 - boxSize / 2,
        y: view.bounds.height / 4 - boxSize / 2,
        width: boxSize,
        height: boxSize)
        holderView.parentFrame = view.frame
        holderView.delegate = self
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

