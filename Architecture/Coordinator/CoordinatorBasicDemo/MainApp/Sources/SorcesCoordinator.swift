//
//  SorcesCoordinator.swift
//  CoordinatorBasicDemo
//
//  Created by Bhavesh Tandel on 28/08/19.
//  Copyright © 2019 Bhavesh Tandel. All rights reserved.
//

import UIKit

class SourcesCoordinator: Coordinator, ObjectLifeLogable {
    var navigationController: UINavigationController
    
    private lazy var sourcesListViewController: SourcesListViewController = {
        let sourcesListViewController = SourcesListViewController()
        return sourcesListViewController
    }()
    
    required init(withNavigationController navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.printObejectLifeEventChanges(state: .initialize)
    }
    
    deinit {
        self.printObejectLifeEventChanges(state: .deinitialize)
    }
    
    func start() {
        self.navigationController.viewControllers = [sourcesListViewController]
        self.navigationController.title = "Source"
    }
    
}
