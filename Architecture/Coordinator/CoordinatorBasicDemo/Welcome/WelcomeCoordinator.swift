//
//  WelcomeCoordinator.swift
//  CoordinatorBasicDemo
//
//  Created by Bhavesh Tandel on 31/08/19.
//  Copyright © 2019 Bhavesh Tandel. All rights reserved.
//

import UIKit

public final class WelcomeCoordinator: Coordinator, ObjectLifeLogable {
    var navigationController: UINavigationController
    var childCoordinator: [Coordinator]
    
    internal var done: (() -> Void) = {}
    
    private lazy var welcomeViewController: WelcomeViewController = {
        let welcomeViewController = WelcomeViewController()
        welcomeViewController.showLoginScreen = { () -> Void in
            self.showLoginScreen()
        }
        welcomeViewController.showCreateAccountScreen = { () -> Void in
            self.showCreateAccountScreen()
        }
        welcomeViewController.showCreateAccountScreen = showCreateAccountScreen
        return welcomeViewController
    }()
    
    init(withNavigationController navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.childCoordinator = []
        self.printObejectLifeEventChanges(state: .initialize)
    }
    
    func start() {
        self.navigationController.viewControllers = [welcomeViewController]
    }
    
    func showLoginScreen() {
        let authCoordintor = AuthenticationCoordinator(withNavigationController: navigationController)
        authCoordintor.loginDone = { [weak self] in
            self?.done()
            self?.childCoordinator.removeAll()
        }
        childCoordinator.append(authCoordintor)
        authCoordintor.login()
    }
    
    func showCreateAccountScreen() {
        let authCoordintor = AuthenticationCoordinator(withNavigationController: navigationController)
        authCoordintor.loginDone = { [weak self] in
            self?.done()
            self?.childCoordinator.removeAll()
        }
        childCoordinator.append(authCoordintor)
        authCoordintor.signUp()
    }
}
