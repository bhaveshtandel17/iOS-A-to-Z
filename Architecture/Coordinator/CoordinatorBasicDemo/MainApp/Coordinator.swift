//
//  Coordinator.swift
//  CoordinatorBasicDemo
//
//  Created by Bhavesh Tandel on 27/08/19.
//  Copyright © 2019 Bhavesh Tandel. All rights reserved.
//

import UIKit
import SafariServices

protocol Coordinator {
    var navigationController: UINavigationController { get }
    init(withNavigationController navigationController: UINavigationController)
    func start()
}

extension Coordinator {
    
    /// Returns the currently visible controller in the current Tab
    public var visibleViewController: UIViewController {
        guard let controller = UIApplication.shared.keyWindow?.rootViewController else { fatalError() }
        return controller.visibleViewController
    }
    
    public func showExternalUrl(url: URL) {
        let safariViewController = SFSafariViewController(url: url)
        self.visibleViewController.present(safariViewController, animated: true, completion: nil)
    }
}

extension UIViewController {
    
    /// Returns the currently visible controller
    fileprivate var visibleViewController: UIViewController {
        if let controller = self as? UINavigationController {
            return controller.topViewController?.visibleViewController ?? controller
        }
        
        if let controller = self as? UITabBarController {
            return controller.selectedViewController?.visibleViewController ?? controller
        }
        
//        if let controller = self as? TabBarController {
//            return controller.selectedViewController?.visibleViewController ?? controller
//        }
        
        if let controller = presentedViewController {
            return controller.visibleViewController
        }
        
        return self
    }
    
    public func fadeDismiss(_ completion: (() -> Void)? = nil) {
        modalTransitionStyle = .crossDissolve
        dismiss(animated: true) {
            completion?()
        }
    }
    
}
