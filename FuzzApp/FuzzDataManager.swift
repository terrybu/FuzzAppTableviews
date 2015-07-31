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

    func getOnlyTextObjects() -> [FuzzObject] {
        var filteredTextObjects = fuzzDataArray.filter({
            $0.type == FuzzType.Text
        })
        return filteredTextObjects
    }
    
    
}
