//
//  LoginViewController.swift
//  CoordinatorBasicDemo
//
//  Created by Bhavesh Tandel on 27/08/19.
//  Copyright © 2019 Bhavesh Tandel. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, ObjectLifeLogable {
    
    internal var doLogin: (() -> Void) = {}

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
    }
    
    deinit {
        self.printObejectLifeEventChanges(state: .deinitialize)
    }


    @IBAction func didLoginTapped(_ sender: UIButton) {
        self.doLogin()
    }
}
