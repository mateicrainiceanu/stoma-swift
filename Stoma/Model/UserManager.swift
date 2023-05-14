//
//  UserManager.swift
//  Stoma
//
//  Created by Matei Crăiniceanu on 11.05.2023.
//

import Foundation

struct UserManager {
    let defaults = UserDefaults.standard

    func setUser(_ user: User) {
        defaults.set(user.name, forKey: "name")
        defaults.set(user.email, forKey: "email")
        defaults.set(user.token, forKey: "token")
    }
    
    func getCurrentUser() -> User? {
        if let name = defaults.string(forKey: "name"), let email = defaults.string(forKey: "email"), let token = defaults.string(forKey: "token"){
            return User(name:name, email:email, token:token)
        } else {
            return nil;
        }
    }
}

struct User {
    let name: String
    let email: String
    let token: String
}
