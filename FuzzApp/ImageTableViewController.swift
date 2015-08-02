//
//  ImageTableViewController.swift
//  FuzzApp
//
//  Created by Terry Bu on 7/30/15.
//  Copyright (c) 2015 Terry Bu. All rights reserved.
//

import UIKit
import JTSImageViewController

class ImageTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    private var imageOnlyObjectsArray: [FuzzObject]?

    
    override func viewDidLoad() {
        loadTableViewWithFilteredData()
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
        
        var cell : ImageTableViewCell! = tableView.dequeueReusableCellWithIdentifier(ImageCellReuseIdentifier) as? ImageTableViewCell
        if (cell == nil) {
            cell = ImageTableViewCell(style:.Default, reuseIdentifier:ImageCellReuseIdentifier)
        }
        
        cell.imgView.image = nil
        
        if let imageObjectsArray = imageOnlyObjectsArray {
            let fuzzObjectForRow = imageObjectsArray[indexPath.row]
            cell.idLabel.text = "ID: \(fuzzObjectForRow.id!)"
            cell.dateLabel.text = fuzzObjectForRow.date
            cell.imgView.setImageWithURL(NSURL(string: fuzzObjectForRow.data!), placeholderImage: UIImage(named: "placeholder"));
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = self.tableView.cellForRowAtIndexPath(indexPath) as! ImageTableViewCell
        var imageInfo = JTSImageInfo()
        imageInfo.image = cell.imgView.image
        imageInfo.referenceRect = cell.imgView.frame
        imageInfo.referenceView = cell.superview
        var imageViewer = JTSImageViewController(imageInfo: imageInfo, mode: JTSImageViewControllerMode.Image, backgroundStyle: JTSImageViewControllerBackgroundOptions.Scaled)
        imageViewer.showFromViewController(self, transition: JTSImageViewControllerTransition._FromOriginalPosition)
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
}
