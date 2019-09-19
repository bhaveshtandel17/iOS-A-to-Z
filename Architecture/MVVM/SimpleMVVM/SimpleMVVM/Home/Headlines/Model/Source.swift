//
//  Source.swift
//  SimpleMVVM
//
//  Created by Bhavesh Tandel on 16/09/19.
//  Copyright © 2019 Bhavesh Tandel. All rights reserved.
//

import Foundation

struct Source {
    var id: String = ""
    var name: String = ""
    
    init() {
        
    }
    
    init(json: Dictionary<String, AnyObject>) {
        self.id = (json["id"] as? String) ?? ""
        self.name = (json["name"] as? String) ?? "Unknown"
    }
}
