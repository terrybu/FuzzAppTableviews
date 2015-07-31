//
//  AllViewController.swift
//  FuzzApp
//
//  Created by Terry Bu on 7/30/15.
//  Copyright (c) 2015 Terry Bu. All rights reserved.
//

import UIKit
import AFNetworking

private let AllCellReuseIdentifier: String = "AllCell"

class AllViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
 
    @IBOutlet weak var tableView: UITableView!
    var fuzzDataArray: [FuzzObject] = []
    
    override func viewDidLoad() {
        let url = NSURL(string: "http://quizzes.fuzzstaging.com/quizzes/mobile/1/data.json")
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!) {(data, response, error) in
            if (error != nil) {
                //error while downloading from url
                println(error.localizedDescription)
                return
            }
            var err: NSError?
            var jsonResultArray = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &err) as! NSArray
            if (err != nil) {
                //error while converting JSON to NSArray
                println(error.localizedDescription)
                return
            }
//            println(jsonResultArray.description)
            for dictObject in jsonResultArray {
                if let dictionary = dictObject as? NSDictionary {
                    let newFuzz = FuzzObject()
                    newFuzz.id = dictionary["id"] as? String
                    newFuzz.date = dictionary["date"] as? String
                    newFuzz.type = dictionary["type"] as? String
                    newFuzz.data = dictionary["data"] as? String
                    self.fuzzDataArray.append(newFuzz)
                }
            }
            dispatch_async(dispatch_get_main_queue()) {
                self.tableView.reloadData()
            }
            
        }
        
        task.resume()
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fuzzDataArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell : AllTableViewCell? = tableView.dequeueReusableCellWithIdentifier(AllCellReuseIdentifier) as? AllTableViewCell
        if (cell == nil) {
            cell = AllTableViewCell(style:.Default, reuseIdentifier:AllCellReuseIdentifier)
        }
        cell!.imgView.image = nil
        
        let fuzzObjectForRow = fuzzDataArray[indexPath.row]
        cell!.idLabel.text = fuzzObjectForRow.id
        cell!.dateLabel.text = fuzzObjectForRow.date
        cell!.typeLabel.text = fuzzObjectForRow.type
        if (fuzzObjectForRow.type == "image") {
            cell!.imgView.setImageWithURL(NSURL(string: fuzzObjectForRow.data!), placeholderImage: UIImage(named: "placeholder"))
        }
        else {
            cell!.dataLabel.text = fuzzObjectForRow.data
        }
        

        return cell!
    }
    
}
