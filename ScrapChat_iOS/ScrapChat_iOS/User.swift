//
//  User.swift
//  ScrapChat_iOS
//
//  Created by Richard Christiansen on 1/10/19.
//  Copyright © 2019 Dream Team. All rights reserved.
//

import Foundation

struct User {
    let firstName: String?
    let lastName: String?
    let email: String?
    let password: String?
    let gender: String?
    let dateOfBirth: String?
    
    init(firstName: String? = nil,
         lastName: String? = nil,
         email: String? = nil,
         password: String? = nil,
         gender: String? = nil,
         dateOfBirth: String? = nil) {
        
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.password = password
        self.gender = gender
        self.dateOfBirth = dateOfBirth
    }
}
