//
//  Article.swift
//  SimpleMVVM
//
//  Created by Bhavesh Tandel on 16/09/19.
//  Copyright © 2019 Bhavesh Tandel. All rights reserved.
//

import Foundation

struct Article {
    var source: Source = Source()
    var author: String = ""
    var title: String = ""
    var description: String = ""
    var url: URL? = nil
    var urlToImage: URL? = nil
    var publishedAt: String = ""
    var content: String = ""
    
    init() {
        
    }
    
    init(json: Dictionary<String, AnyObject>) {
        self.source = Source(json: json["source"] as? Dictionary<String, AnyObject> ?? [:])
        self.author = (json["author"] as? String) ?? "Unknown"
        self.title = (json["title"] as? String) ?? "Unknown"
        self.description = (json["description"] as? String) ?? "Unknown"
        self.url = URL(string: json["url"] as? String ?? "")
        self.urlToImage = URL(string: json["urlToImage"] as? String ?? "")
        self.publishedAt = (json["publishedAt"] as? String) ?? "Unknown"
        self.content = (json["content"] as? String) ?? ""
    }
}
