//
//  AppCoordinator.swift
//  CoordinatorBasicDemo
//
//  Created by Bhavesh Tandel on 27/08/19.
//  Copyright © 2019 Bhavesh Tandel. All rights reserved.
//

import UIKit

class AppCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    required init(withNavigationController navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        self.loadRootTabViewcontroller()
    }
    
}

extension AppCoordinator {
    
    func showWelcomeScreen() {
        guard UserDefaults.standard.bool(forKey: "loginStatus") == false else { return }
        let welcomeCoordinator = WelcomeCoordinator(withNavigationController: UINavigationController())
        welcomeCoordinator.done = { [weak self] in
            self?.navigationController.visibleViewController?.dismiss(animated: true, completion: nil)
            UserDefaults.standard.set(true, forKey: "loginStatus")
            self?.childCoordinators.removeLast()
        }
        welcomeCoordinator.start()
        self.childCoordinators.append(welcomeCoordinator)
        //Getting error : Warning: Attempt to present <UINavigationController: 0x7fddb7000000> on <CoordinatorBasicDemo.RootViewController: 0x7fddbb021200> whose view is not in the window hierarchy!
     
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.navigationController.visibleViewController?.present(welcomeCoordinator.navigationController, animated: true, completion: nil)
        }
    }
}

// RootViewController
extension AppCoordinator {
    private func loadRootTabViewcontroller() {
        let rootViewController = RootViewController()
        
        //TAB 1 : Headline
        let headlineCoordinator = HeadlineCoordinator(withNavigationController: UINavigationController())
        headlineCoordinator.showArticleOnWebView = showArticleOnWebView
        headlineCoordinator.start()
        childCoordinators.append(headlineCoordinator)
        
        //TAB 2 : Source
        let sourcesCoordinator = SourcesCoordinator(withNavigationController: UINavigationController())
        sourcesCoordinator.start()
        childCoordinators.append(sourcesCoordinator)
        
        //TAB 3 : World
        let worldCoordinator = WorldCoordinator(withNavigationController: UINavigationController())
        worldCoordinator.start()
        childCoordinators.append(worldCoordinator)
        
        //TAB 4 : Video
        let videoCoordinator = ViedosCoordinator(withNavigationController: UINavigationController())
        videoCoordinator.start()
        childCoordinators.append(videoCoordinator)
        
        //TAB 5 : More
        let moreCoordinator = MoreCoordinator(withNavigationController: UINavigationController())
        moreCoordinator.start()
        childCoordinators.append(moreCoordinator)
        
        rootViewController.setupTabBarControllerWith(viewControllers: childCoordinators.map{ $0.navigationController })
        navigationController.viewControllers = [rootViewController]
        
        self.showWelcomeScreen()
    }
    
    func showArticleOnWebView(url: URL?) {
        guard let webURL = url else { return }
        //let webController = WebViewController()
        //webController.url = webURL
        self.showExternalUrl(url: webURL)
        
    }
}
