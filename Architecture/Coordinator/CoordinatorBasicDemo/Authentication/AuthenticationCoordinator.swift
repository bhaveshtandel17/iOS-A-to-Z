//
//  AuthenticationCoordinator.swift
//  CoordinatorBasicDemo
//
//  Created by Bhavesh Tandel on 27/08/19.
//  Copyright © 2019 Bhavesh Tandel. All rights reserved.
//

import UIKit

class AuthenticationCoordinator: Coordinator, ObjectLifeLogable {
    
    var navigationController: UINavigationController
    
    private lazy var loginViewController: LoginViewController = {
         let loginViewController = LoginViewController()
        loginViewController.doLogin = doLogin
        return loginViewController
    }()
    
    private lazy var signupViewController: SignUpViewController = {
        let signupViewController = SignUpViewController()
        signupViewController.createAccount = createAccount
        return signupViewController
    }()
    
    internal var loginDone: (() -> Void) = {}
    internal var signupDone: (() -> Void) = {}
    
    required init(withNavigationController navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.printObejectLifeEventChanges(state: .initialize)
    }
    
    deinit {
        self.printObejectLifeEventChanges(state: .deinitialize)
    }
    
    func start() {
        // Nothing to do
    }
    
    func login() {
        navigationController.pushViewController(self.loginViewController, animated: true)
    }
    
    func signUp() {
        navigationController.pushViewController(self.signupViewController, animated: true)
    }
}

// LoginViewController event
extension AuthenticationCoordinator {
    func doLogin() {
        // API CALL
        self.loginDone()
    }
}

// Signupviewcontroller event
extension AuthenticationCoordinator {
    func createAccount() {
        // API CALL
        self.signupDone()
    }
}
