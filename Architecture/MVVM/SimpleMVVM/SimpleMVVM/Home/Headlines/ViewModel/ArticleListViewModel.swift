//
//  ArticleListViewModel.swift
//  SimpleMVVM
//
//  Created by Bhavesh Tandel on 16/09/19.
//  Copyright © 2019 Bhavesh Tandel. All rights reserved.
//

import Foundation

class ArticleListViewModel {
    
    init(articleViewModelList: [ArticleViewModel] = []) {
        self.articleViewModelList = Box(articleViewModelList)
    }
    
    //DATA BINDING
    var articleViewModelList: Box<[ArticleViewModel]> = Box([])
    
    //Subscript
    subscript(index: Int) -> ArticleViewModel {
        return self.articleViewModelList.value[index]
    }
    
}

//Presentation
extension ArticleListViewModel {
    var totalArticleCount: Int {
        return articleViewModelList.value.count
    }
}

//Networking
extension ArticleListViewModel {
    func fetchHeadlines(countryCode: String,pageNumber page: Int = 0) {
        NewsService.fetchHeadlines(countryCode: countryCode) { [weak self] articleList in
            guard let articles = articleList else { return }
            let newViewModelList = articles.map{ ArticleViewModel(article: $0) }
            self?.articleViewModelList.value.append(contentsOf: newViewModelList)
        }
    }
}
