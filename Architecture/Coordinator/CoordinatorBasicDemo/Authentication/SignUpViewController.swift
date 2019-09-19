//
//  SignUpViewController.swift
//  CoordinatorBasicDemo
//
//  Created by Bhavesh Tandel on 27/08/19.
//  Copyright © 2019 Bhavesh Tandel. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {

    internal var createAccount: (() -> Void) = {}
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func signUpTapped(_ sender: Any) {
        self.createAccount()
    }
    

}
