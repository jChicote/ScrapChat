//
//  DatabaseManager.swift
//  ScrapChat_iOS
//
//  Created by Richard James on 22/9/19.
//  Copyright © 2019 Dream Team. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class DatabaseManager {
    let db = Firestore.firestore()
    
    func createAccount(firstName: String, lastName: String, gender: String, dateOfBirth: String, userID: String) -> Bool {
        //var completion: Bool = true
        let ref = db.collection("users").document(Auth.auth().currentUser!.uid)
        //ref.setData(["firstname":firstName,"lastname":lastName,"UID":userID]), completion: error in {
        ref.setData(["firstname":firstName,"lastname":lastName,"gender":gender,"UID":userID])
        return true
    }
    
    func updateLastLoggedIn() {
        let ref = db.collection("users").document(Auth.auth().currentUser!.uid)
        ref.setData(["lastonline":FieldValue.serverTimestamp()], merge: true)
    }
    
    func getData() {
        let docRef = db.collection("users").document(Auth.auth().currentUser!.uid)
        docRef.getDocument { (snapshot, error) in
            if error == nil {
                let fName = snapshot?.get("firstname")
                print(fName as Any)
            }
        }
    }
}
