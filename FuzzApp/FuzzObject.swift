//
//  FuzzObject.swift
//  FuzzApp
//
//  Created by Terry Bu on 7/30/15.
//  Copyright (c) 2015 Terry Bu. All rights reserved.
//

import Foundation

class FuzzObject {
    
    var id: String?
    var type: String?
    var date: String?
    var data: String?
    
    init(id: String, type: String, date: String, data: String) {
        self.id = id
        self.type = type
        self.date = date
        self.data = data
    }
    
}