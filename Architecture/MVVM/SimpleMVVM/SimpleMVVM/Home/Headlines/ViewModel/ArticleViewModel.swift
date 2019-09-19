//
//  ArticleViewModel.swift
//  SimpleMVVM
//
//  Created by Bhavesh Tandel on 16/09/19.
//  Copyright © 2019 Bhavesh Tandel. All rights reserved.
//

import Foundation

class ArticleViewModel {
    //Model
    private var article: Article
    
    init(article: Article = Article()) {
        self.article = article
    }
}

//Presentation
extension ArticleViewModel {
    var title: String {
        return article.title
    }
    
    var description: String {
        return article.description
    }
    
    var info: String {
        return "Published By: \(article.source.name) on \(article.publishedAt)"
    }
    
    var url: URL? {
        return article.url
    }
}
