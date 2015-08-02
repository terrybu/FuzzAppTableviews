//
//  FuzzDataManager.swift
//  FuzzApp
//
//  Created by Terry Bu on 7/31/15.
//  Copyright (c) 2015 Terry Bu. All rights reserved.
//

import UIKit

class FuzzDataManager {
    
    var fuzzDataArray: [FuzzObject] = []
    
    class var sharedManager : FuzzDataManager {
        
        struct Static {
            static var instance : FuzzDataManager?
            static var token : dispatch_once_t = 0
        }
        
        dispatch_once(&Static.token) {
            Static.instance = FuzzDataManager()
        }
        
        return Static.instance!
    }
    
    func getJSONDataFromEndpoint(completion: (result: Bool) -> Void) {
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
            for dictObject in jsonResultArray {
                if let dictionary = dictObject as? NSDictionary {
                    let newFuzz = FuzzObject()
                    newFuzz.id = dictionary["id"] as? String
                    newFuzz.date = dictionary["date"] as? String
                    newFuzz.setType((dictionary["type"] as? String)!)
                    newFuzz.data = dictionary["data"] as? String
                    self.fuzzDataArray.append(newFuzz)
                }
            }
            NSNotificationCenter.defaultCenter().postNotificationName(kFuzzDataDownloadComplete, object: nil)
            completion(result: true)
            
        }
        task.resume()
    }

    func getOnlyTextObjects() -> [FuzzObject]? {
        if fuzzDataArray.count > 0 {
            var filteredTextObjects = fuzzDataArray.filter({
                $0.type == FuzzType.Text
            })
            return filteredTextObjects
        }
        return nil
    }
    
    func getOnlyImageObjects() -> [FuzzObject]? {
        if fuzzDataArray.count > 0 {
            var filteredImageObjects = fuzzDataArray.filter({
                $0.type == FuzzType.Image
            })
            return filteredImageObjects
        }
        return nil
    }
    
    
}
