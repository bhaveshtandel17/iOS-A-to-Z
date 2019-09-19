//
//  ViedosCoordinator.swift
//  CoordinatorBasicDemo
//
//  Created by Bhavesh Tandel on 29/08/19.
//  Copyright © 2019 Bhavesh Tandel. All rights reserved.
//

import UIKit

class ViedosCoordinator: Coordinator, ObjectLifeLogable {
    var navigationController: UINavigationController
    
    private lazy var videoViewController: VideosViewController = {
        let videoViewController = VideosViewController()
        return videoViewController
    }()
    
    required init(withNavigationController navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.printObejectLifeEventChanges(state: .initialize)
    }
    
    deinit {
        self.printObejectLifeEventChanges(state: .deinitialize)
    }
    
    func start() {
        self.navigationController.viewControllers = [videoViewController]
        self.navigationController.title = "Video"
    }
}
