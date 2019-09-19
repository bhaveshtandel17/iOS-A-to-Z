//
//  Source.swift
//  CoordinatorBasicDemo
//
//  Created by Bhavesh Tandel on 29/08/19.
//  Copyright © 2019 Bhavesh Tandel. All rights reserved.
//

import Foundation

struct Source {
    let id: String
    let name: String
    
    init(json: Dictionary<String, AnyObject>) {
        self.id = (json["id"] as? String) ?? ""
        self.name = (json["name"] as? String) ?? "Unknown"
    }
}
