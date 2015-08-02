//
//  TextTableViewController.swift
//  FuzzApp
//
//  Created by Terry Bu on 7/30/15.
//  Copyright (c) 2015 Terry Bu. All rights reserved.
//

import UIKit
import WebKit

class TextTableViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    private var textOnlyObjectsArray: [FuzzObject]?
    
    override func viewDidLoad() {
        loadTableViewWithFilteredData()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "loadTableViewWithFilteredData", name: kFuzzDataDownloadComplete, object: nil)
    }
    
    @objc
    private func loadTableViewWithFilteredData() {
        textOnlyObjectsArray = FuzzDataManager.sharedManager.getOnlyTextObjects()
        if textOnlyObjectsArray != nil {
            tableView.reloadData()
        }
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
}

extension TextTableViewController: UITableViewDataSource {
    
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
        
        var cell : TextTableViewCell! = tableView.dequeueReusableCellWithIdentifier(TextCellReuseIdentifier) as? TextTableViewCell
        if (cell == nil) {
            cell = TextTableViewCell(style:.Default, reuseIdentifier:TextCellReuseIdentifier)
        }
        if let textObjectsArray = textOnlyObjectsArray {
            let fuzzObjectForRow = textObjectsArray[indexPath.row]
            cell.idLabel.text = "ID: \(fuzzObjectForRow.id!)"
            cell.dateLabel.text = fuzzObjectForRow.date
            cell.dataTextView.text = fuzzObjectForRow.data
            
        }
        return cell
    }
}

extension TextTableViewController: UITableViewDelegate {
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if let textObjectsArray = textOnlyObjectsArray {
            let fuzzObjectForRow = textObjectsArray[indexPath.row]
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: 300, height: 10000))
            label.text = fuzzObjectForRow.data
            label.numberOfLines = 10
            label.font = UIFont(name: "Times New Roman", size: 19.0)
            label.sizeToFit()
            let calculatedHeight = label.frame.height + 10
            if (calculatedHeight) > 66 {
                return calculatedHeight
            }
        }
        return 66
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let webViewController = UIViewController()
        let wkWebView = WKWebView(frame: self.view.frame)
        let url = NSURL(string: "https://fuzzproductions.com/")
        let request = NSURLRequest(URL: url!)
        wkWebView.loadRequest(request)
        webViewController.view = wkWebView
        self.navigationController?.pushViewController(webViewController, animated: true)
    }

}
