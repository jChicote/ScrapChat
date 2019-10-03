//
//  Person.swift
//  ScrapChat_iOS
//
//  Created by Jaiden Chicote on 3/10/19.
//  Copyright © 2019 Dream Team. All rights reserved.
//

import Foundation
import UIKit

class Person {
    
    var name: String
    var age: Int
    var suburb: String
    var gender: String
    
    init(name: String, age: Int, suburb: String, gender: String) {
        self.name = name
        self.age = age
        self.suburb = suburb
        self.gender = gender
    }
}
