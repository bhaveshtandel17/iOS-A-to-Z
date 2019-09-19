//
//  RootViewController.swift
//  CoordinatorBasicDemo
//
//  Created by Bhavesh Tandel on 28/08/19.
//  Copyright © 2019 Bhavesh Tandel. All rights reserved.
//

import UIKit

class RootViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func setupTabBarControllerWith(viewControllers: [UIViewController]) {
        self.viewControllers = viewControllers
    }

}
