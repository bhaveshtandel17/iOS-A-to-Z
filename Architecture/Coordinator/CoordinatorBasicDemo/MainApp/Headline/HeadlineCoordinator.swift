//
//  HeadlineCoordinator.swift
//  CoordinatorBasicDemo
//
//  Created by Bhavesh Tandel on 28/08/19.
//  Copyright © 2019 Bhavesh Tandel. All rights reserved.
//

import UIKit

class HeadlineCoordinator: Coordinator, ObjectLifeLogable {
    var navigationController: UINavigationController
    
    required init(withNavigationController navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.printObejectLifeEventChanges(state: .initialize)
    }
    
    private lazy var newsListViewcontroller: NewsListViewController = {
        let newsListViewController = NewsListViewController()
        newsListViewController.getEndPoint = { [weak self]() -> String? in
            
            return "top-headlines?country=\(String(describing: self?.countryCode ?? ""))&apiKey=\(AppConstant.apiKey)"
        }
        newsListViewController.showArticleOnWebView = { [weak self] (url) -> Void in
            self?.showArticleOnWebView(url)
        }
        return newsListViewController
    }()
    
    var countryCode: String = (Locale.current as NSLocale).object(forKey: .countryCode) as? String ?? "in"
    
    internal var showArticleOnWebView: ((_ url: URL?) -> Void) = {_ in }
    
    func start() {
        self.navigationController.viewControllers = [self.newsListViewcontroller]
        self.navigationController.title = "Headline"
    }
    
    deinit {
        printObejectLifeEventChanges(state: .deinitialize)
    }

}
