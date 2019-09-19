//
//  LoginService.swift
//  SimpleMVVM
//
//  Created by Bhavesh Tandel on 16/09/19.
//  Copyright © 2019 Bhavesh Tandel. All rights reserved.
//

import Foundation

struct LoginService {
    static func loginWith(userName: String, password: String, completion: (_ success: Bool) -> Void) {
        //Mock DATA
        completion(true)
    }
    
    static func generateAccessCode() -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String((0..<5).map{ _ in letters.randomElement()! })
    }
}
