//
//  AllViewController.swift
//  FuzzApp
//
//  Created by Terry Bu on 7/30/15.
//  Copyright (c) 2015 Terry Bu. All rights reserved.
//

import UIKit

//Just wanted to show I understand how to set up tableview using UIViewController (which allows for more granular control compared to UITableViewController) 

class AllViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
 
    var dataArray: [FuzzObject]?
    
    override func viewDidLoad() {
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let fuzzArray = dataArray {
            return fuzzArray.count
        }
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        return cell
    }
    
}
