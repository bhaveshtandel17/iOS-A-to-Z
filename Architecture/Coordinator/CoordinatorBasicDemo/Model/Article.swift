//
//  Article.swift
//  CoordinatorBasicDemo
//
//  Created by Bhavesh Tandel on 29/08/19.
//  Copyright © 2019 Bhavesh Tandel. All rights reserved.
//

import Foundation

struct Article {
    let source: Source
    let author: String
    let title: String
    let description: String
    let url: URL?
    let urlToImage: URL?
    let publishedAt: String
    let content: String
    
    
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
