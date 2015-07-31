//
//  FuzzObject.swift
//  FuzzApp
//
//  Created by Terry Bu on 7/30/15.
//  Copyright (c) 2015 Terry Bu. All rights reserved.
//

import Foundation

enum FuzzType: String {
    case Text = "text",
    Image = "image",
    Other = "other"
}

class FuzzObject {
    
    var id: String?
    var type: FuzzType? {
        didSet {
            
        }
    }
    var date: String?
    var data: String?
    
    convenience init(id: String, type: FuzzType, date: String, data: String) {
        self.init()
        self.id = id
        self.type = type
        self.date = date
        self.data = data
    }
    
    func setType(typeString: String) {
        switch typeString {
        case FuzzType.Text.rawValue:
            self.type = FuzzType.Text
        case FuzzType.Image.rawValue:
            self.type = FuzzType.Image
        default:
            self.type = FuzzType.Other
        }
        
    }
    
}