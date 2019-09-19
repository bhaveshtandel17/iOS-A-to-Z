//
//  LoginViewController.swift
//  SimpleMVVM
//
//  Created by Bhavesh Tandel on 16/09/19.
//  Copyright © 2019 Bhavesh Tandel. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    //ViewModel
    private var userViewModel = UserViewModel()
    
    //IBOutlets
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var codelTextField: UITextField!
    @IBOutlet weak var codeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.dataBinding()
    }
    
    //Data Binding: view with model using Boxing
    private func dataBinding() {
        userViewModel.accessCode.bindAndFire { [unowned self] code in
            self.codeLabel.text = code
        }
        
        userViewModel.userName.bindAndFire { newUserName in
            print("Username is changed: \(newUserName)")
        }
    }
    
    
    @IBAction func loginClicked(_ sender: Any) {
        switch userViewModel.validate() {
        case .invalid(let error):
            showErrorMessage(error: error)
        case .valid:
            userViewModel.login { errorMessage in
                if let errorMessage = errorMessage {
                    showErrorMessage(error: errorMessage)
                } else {
                    self.performSegue(withIdentifier: "HomeSegue", sender: nil)
                }
            }
        }
    }
    
    private func showErrorMessage(error: String) {
        let alert = UIAlertController(title: nil, message: error, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
        
    
}


//MARK: UITextFieldDelegate
extension LoginViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == userNameTextField {
            textField.text = userViewModel.userName.value
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == userNameTextField {
            textField.text = userViewModel.protectedUserName
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == userNameTextField {
            passwordTextField.becomeFirstResponder()
        } else if textField == passwordTextField {
            codelTextField.becomeFirstResponder()
        } else if textField == codelTextField {
            
        }
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let newString = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        if textField == userNameTextField {
            userViewModel.update(userName: newString)
        } else if textField == passwordTextField {
            userViewModel.update(password: newString)
        }
        return true
    }
}

