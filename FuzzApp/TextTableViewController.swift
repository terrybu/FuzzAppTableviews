//
//  TextTableViewController.swift
//  FuzzApp
//
//  Created by Terry Bu on 7/30/15.
//  Copyright (c) 2015 Terry Bu. All rights reserved.
//

import UIKit

private let TextCellReuseIdentifier: String = "TextCell"

class TextTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    private var textOnlyObjectsArray: [FuzzObject]?
    
    override func viewDidLoad() {
        loadTableViewWithFilteredData()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "loadTableViewWithFilteredData", name: kFuzzDataDownloadComplete, object: nil)
    }
    
    @objc
    private func loadTableViewWithFilteredData() {
        println("loading text tableview")
        textOnlyObjectsArray = FuzzDataManager.sharedManager.getOnlyTextObjects()
        if let textObjectsArray = textOnlyObjectsArray {
            tableView.reloadData()
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let textObjectsArray = textOnlyObjectsArray {
            return textObjectsArray.count
        }
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell : TextTableViewCell? = tableView.dequeueReusableCellWithIdentifier(TextCellReuseIdentifier) as? TextTableViewCell
        if (cell == nil) {
            cell = TextTableViewCell(style:.Default, reuseIdentifier:TextCellReuseIdentifier)
        }
        if let textObjectsArray = textOnlyObjectsArray {
            let fuzzObjectForRow = textObjectsArray[indexPath.row]
            cell!.idLabel.text = fuzzObjectForRow.id
            cell!.dateLabel.text = fuzzObjectForRow.date
            cell!.dataLabel.text = fuzzObjectForRow.data
        }

        return cell!
    }
    
}
