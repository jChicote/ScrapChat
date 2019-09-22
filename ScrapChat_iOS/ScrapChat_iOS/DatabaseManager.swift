//
//  DatabaseManager.swift
//  ScrapChat_iOS
//
//  Created by Richard James on 22/9/19.
//  Copyright © 2019 Dream Team. All rights reserved.
//

import Foundation
import FirebaseFirestore

class DatabaseManager {
    let db = Firestore.firestore()
    
    func createAccount(firstName: String, lastName: String, userID: String) -> Bool {
        var completion: Bool = true
        db.collection("users").addDocument(data: ["firstname":firstName,"lastname":lastName,"UID":userID]) { (error) in
            if error != nil {
                completion = false
            }
            else {
                completion = true
            }
        }
        return completion
    }
}
