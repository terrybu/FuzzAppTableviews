//
//  AllViewController.swift
//  FuzzApp
//
//  Created by Terry Bu on 7/30/15.
//  Copyright (c) 2015 Terry Bu. All rights reserved.
//

import UIKit
import AFNetworking
import WebKit
import JTSImageViewController

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
                    cell = tableView.dequeueReusableCellWithIdentifier(AllTextCellReuseIdentifier) as! AllTextTableViewCell
                    if (cell == nil) {
                        cell = AllTextTableViewCell(style:.Default, reuseIdentifier:AllTextCellReuseIdentifier)
                    }
                    (cell as! AllTextTableViewCell).idLabel.text = "ID: \(fuzzObjectForRow.id!)"
                    (cell as! AllTextTableViewCell).dateLabel.text = fuzzObjectForRow.date
                    (cell as! AllTextTableViewCell).dataLabel.text = fuzzObjectForRow.data
                    (cell as! AllTextTableViewCell).dataLabel.sizeToFit()

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
                    (cell as! AllTableViewCell).imgView.image = nil
                    (cell as! AllTableViewCell).typeLabel.text = "Type: \(fuzzObjectForRow.type!.rawValue)"
                    break
            }
        }
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if let objectsArray = allFuzzObjectsArray {
            let fuzzObjectForRow = objectsArray[indexPath.row]
            if fuzzObjectForRow.type == FuzzType.Text {
                let label = UILabel(frame: CGRect(x: 0, y: 0, width: 300, height: 1000))
                label.text = fuzzObjectForRow.data
                label.font = UIFont(name: "Times New Roman", size: 14.0)
                label.numberOfLines = 0
                label.sizeToFit()
                let calculatedHeight = label.frame.height
                if (calculatedHeight) > 88 {
                    return calculatedHeight
                }
            }
        }
        return 88
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = self.tableView.cellForRowAtIndexPath(indexPath)
        if let allObjectsArray = allFuzzObjectsArray {
            let fuzzObjectForRow = allObjectsArray[indexPath.row]
            if fuzzObjectForRow.type == FuzzType.Text {
                let webViewController = UIViewController()
                let wkWebView = WKWebView(frame: self.view.frame)
                let url = NSURL(string: "https://fuzzproductions.com/")
                let request = NSURLRequest(URL: url!)
                wkWebView.loadRequest(request)
                webViewController.view = wkWebView
                self.navigationController?.pushViewController(webViewController, animated: true)
            }
            else if fuzzObjectForRow.type == FuzzType.Image {
                var imageInfo = JTSImageInfo()
                imageInfo.image = (cell as! AllTableViewCell).imgView.image
                imageInfo.referenceRect = (cell as! AllTableViewCell).imgView.frame
                imageInfo.referenceView = (cell as! AllTableViewCell).superview
                var imageViewer = JTSImageViewController(imageInfo: imageInfo, mode: JTSImageViewControllerMode.Image, backgroundStyle: JTSImageViewControllerBackgroundOptions.Scaled)
                imageViewer.showFromViewController(self, transition: JTSImageViewControllerTransition._FromOriginalPosition)
            }
        }
    }
    
}
