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
    var textObjectsArray: [FuzzObject] = []
    
    override func viewDidLoad() {
        textObjectsArray = FuzzDataManager.sharedManager.getOnlyTextObjects()
        tableView.reloadData()
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return textObjectsArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell : TextTableViewCell? = tableView.dequeueReusableCellWithIdentifier(TextCellReuseIdentifier) as? TextTableViewCell
        if (cell == nil) {
            cell = TextTableViewCell(style:.Default, reuseIdentifier:TextCellReuseIdentifier)
        }
        
        let fuzzObjectForRow = textObjectsArray[indexPath.row]
        cell!.idLabel.text = fuzzObjectForRow.id
        cell!.dateLabel.text = fuzzObjectForRow.date
        cell!.dataLabel.text = fuzzObjectForRow.data
        return cell!
    }
    
}
