//
//  AllViewController.swift
//  FuzzApp
//
//  Created by Terry Bu on 7/30/15.
//  Copyright (c) 2015 Terry Bu. All rights reserved.
//

import UIKit
import AFNetworking


class AllTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
 
    @IBOutlet weak var tableView: UITableView!
    private var allFuzzObjectsArray: [FuzzObject]? {
        get {
            return FuzzDataManager.sharedManager.fuzzDataArray
        }
    }
    
    override func viewDidLoad() {
        
        tabBarController?.tabBar.tintColor = UIColor.whiteColor()
        FuzzDataManager.sharedManager.getJSONDataFromEndpoint { (dataParsingComplete) -> Void in
            if (dataParsingComplete) {
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.tableView.reloadData()
                })
                
            }
        }

    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let allObjectsArray = allFuzzObjectsArray {
            return allObjectsArray.count
        }
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell: UITableViewCell!

        if let allObjectsArray = allFuzzObjectsArray {
            let fuzzObjectForRow = allObjectsArray[indexPath.row]
            
            switch fuzzObjectForRow.type! {
                case FuzzType.Text:
                    cell = tableView.dequeueReusableCellWithIdentifier(TextCellReuseIdentifier) as! TextTableViewCell
                    if (cell == nil) {
                        cell = TextTableViewCell(style:.Default, reuseIdentifier:TextCellReuseIdentifier)
                    }
                    (cell as! TextTableViewCell).idLabel.text = "ID: \(fuzzObjectForRow.id!)"
                    (cell as! TextTableViewCell).dateLabel.text = fuzzObjectForRow.date
                    (cell as! TextTableViewCell).dataLabel.text = fuzzObjectForRow.data
                    break
                case FuzzType.Image:
                    cell = tableView.dequeueReusableCellWithIdentifier(AllCellReuseIdentifier) as! AllTableViewCell
                    (cell as! AllTableViewCell).imgView.image = nil
                    (cell as! AllTableViewCell).idLabel.text = "ID: \(fuzzObjectForRow.id!)"
                    (cell as! AllTableViewCell).dateLabel.text = fuzzObjectForRow.date
                    (cell as! AllTableViewCell).dataLabel.text = nil
                    (cell as! AllTableViewCell).imgView.setImageWithURL(NSURL(string: fuzzObjectForRow.data!), placeholderImage: UIImage(named: "placeholder"));
                    (cell as! AllTableViewCell).typeLabel.text = "Type: \(fuzzObjectForRow.type!.rawValue)"
                    break
                default:
                    cell = tableView.dequeueReusableCellWithIdentifier(AllCellReuseIdentifier) as! AllTableViewCell
                    (cell as! AllTableViewCell).idLabel.text = "ID: \(fuzzObjectForRow.id!)"
                    (cell as! AllTableViewCell).dateLabel.text = fuzzObjectForRow.date
                    (cell as! AllTableViewCell).dataLabel.text = nil
                    (cell as! AllTableViewCell).typeLabel.text = "Type: \(fuzzObjectForRow.type!.rawValue)"
                    break
            }
        }
       
        return cell
    }
    
}
