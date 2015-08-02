//
//  ImageTableViewController.swift
//  FuzzApp
//
//  Created by Terry Bu on 7/30/15.
//  Copyright (c) 2015 Terry Bu. All rights reserved.
//

import UIKit


class ImageTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    private var imageOnlyObjectsArray: [FuzzObject]?

    
    override func viewDidLoad() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "loadTableViewWithFilteredData", name: kFuzzDataDownloadComplete, object: nil)
    }
    
    @objc
    private func loadTableViewWithFilteredData() {
        imageOnlyObjectsArray = FuzzDataManager.sharedManager.getOnlyImageObjects()
        if imageOnlyObjectsArray != nil {
            tableView.reloadData()
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let imageObjectsArray = imageOnlyObjectsArray {
            return imageObjectsArray.count
        }
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell : TextTableViewCell? = tableView.dequeueReusableCellWithIdentifier(TextCell2ReuseIdentifier) as? TextTableViewCell
        if (cell == nil) {
            cell = TextTableViewCell(style:.Default, reuseIdentifier:TextCell2ReuseIdentifier)
        }
        if let imageObjectsArray = imageOnlyObjectsArray {
            let fuzzObjectForRow = imageObjectsArray[indexPath.row]
            cell!.idLabel.text = "ID: \(fuzzObjectForRow.id!)"
            cell!.dateLabel.text = fuzzObjectForRow.date
            cell!.dataLabel.text = fuzzObjectForRow.data
        }
        
        return cell!
    }
    
}
