//
//  UserViewModel.swift
//  SimpleMVVM
//
//  Created by Bhavesh Tandel on 16/09/19.
//  Copyright © 2019 Bhavesh Tandel. All rights reserved.
//

import Foundation

enum UserValidationState {
    case valid
    case invalid(String)
}

class UserViewModel {
    //Model
    private var user: User {
        //User is struct; Means if any user property chages didSet is called.
        // Because struct is value type. After updation in struct, new struct value is generated.
        didSet {
            userName.value = user.username
        }
    }
    
    //Constants
    private let visibleUsernameLength = 3
    private let minUsernameLength = 4
    private let minPasswordLength = 4
    private let codeRefreshTime = 5.0
    
    //DATA BINDING
    var accessCode: Box<String?> = Box(nil) //Bind non Model
    var userName: Box<String> = Box("") // Bind Model's Property
    
    //INIT
    init(user: User = User()) {
        self.user = user
        self.startAccessCodeTimer()
    }
}

// Setter; Because View doesn't have access to model
extension UserViewModel {
    func update(userName: String) {
        user.username = userName
    }
    
    func update(password: String) {
        user.password = password
    }
}

//Presentation Logic
extension UserViewModel {
    
    var password: String {
        return user.password
    }
    
    var protectedUserName: String {
        var userName = self.userName.value
        if userName.count > visibleUsernameLength {
            let endIndex = userName.index(userName.endIndex, offsetBy: -visibleUsernameLength)
            userName.replaceSubrange(userName.startIndex..<endIndex,
                              with: String(repeating: "*", count: userName.count-visibleUsernameLength))
            return userName
        }
        return userName
    }
    
    
}

//Validation Logic
extension UserViewModel {
    func validate() -> UserValidationState {
        if user.username.isEmpty || user.password.isEmpty {
            return .invalid("Username and password are required.")
        }
        
        if user.username.count < minUsernameLength {
            return .invalid("Username needs to be at least \(minUsernameLength) characters long.")
        }
        
        if user.username.count < minPasswordLength {
            return .invalid("Password needs to be at least \(minPasswordLength) characters long.")
        }
        
        return .valid
    }
}

//Network logic
extension UserViewModel {
    func login(completion: (_ errorString: String?) -> Void) {
        LoginService.loginWith(userName: user.username, password: user.password) { success in
            if success {
                completion(nil)
            } else {
                completion("Invalid credentials")
            }
        }
    }
}


private extension UserViewModel {
    func startAccessCodeTimer() {
        // Databinding : Updated value
        accessCode.value = LoginService.generateAccessCode()
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + codeRefreshTime) { [weak self] in //Break retain cycle
            self?.startAccessCodeTimer()
        }
    }
}
