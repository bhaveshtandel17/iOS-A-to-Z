//
//  WorldCoordinator.swift
//  CoordinatorBasicDemo
//
//  Created by Bhavesh Tandel on 29/08/19.
//  Copyright © 2019 Bhavesh Tandel. All rights reserved.
//

import UIKit

class WorldCoordinator: Coordinator, ObjectLifeLogable {
    var navigationController: UINavigationController
    
    private lazy var worldViewController: WorldViewController = {
        let worldViewController = WorldViewController()
        worldViewController.showHeadlineForCountry = { [weak self] (code) -> Void in
            let newsListViewcontroller = NewsListViewController()
            newsListViewcontroller.getEndPoint = {
                [weak self]() -> String? in
                
                return "top-headlines?country=\(String(describing: code))&apiKey=\(AppConstant.apiKey)"
            }
            newsListViewcontroller.showArticleOnWebView = { [weak self] (url) -> Void in
                guard let urlToShow = url else { return }
                self?.showExternalUrl(url: urlToShow)
            }
            self?.navigationController.pushViewController(newsListViewcontroller, animated: true)
        }
        return worldViewController
    }()
    
    required init(withNavigationController navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.printObejectLifeEventChanges(state: .initialize)
    }
    
    deinit {
        self.printObejectLifeEventChanges(state: .deinitialize)
    }
    
    func start() {
        self.navigationController.viewControllers = [worldViewController]
        self.navigationController.title = "World"
    }
}
