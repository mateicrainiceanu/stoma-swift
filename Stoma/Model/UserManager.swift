//
//  UserManager.swift
//  Stoma
//
//  Created by Matei Crăiniceanu on 11.05.2023.
//

import Foundation

struct UserManager {
    
    func authenticate(name:String, email:String, password:String) {
        let url = apiproxy + "/register"
    }
    
    func authenticate(email:String, password: String){
        let url = apiproxy + "/login"
    }
}
