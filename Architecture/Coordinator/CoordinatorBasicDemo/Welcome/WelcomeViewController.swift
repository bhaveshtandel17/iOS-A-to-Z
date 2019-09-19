//
//  WelcomeViewController.swift
//  CoordinatorBasicDemo
//
//  Created by Bhavesh Tandel on 27/08/19.
//  Copyright © 2019 Bhavesh Tandel. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {

    
    internal var showLoginScreen: (() -> Void) = {}
    internal var showCreateAccountScreen: (() -> Void) = {}
    internal var skipLogin: (() -> Void) = {}

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func loginTapped(_ sender: UIButton) {
        self.showLoginScreen()
    }
    
    @IBAction func singupTapped(_ sender: UIButton) {
        self.showCreateAccountScreen()
    }
    
    @IBAction func skipTapped(_ sender: UIButton) {
        self.skipLogin()
    }
}
