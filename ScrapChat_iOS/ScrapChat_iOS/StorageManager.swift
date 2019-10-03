//
//  StorageManager.swift
//  ScrapChat_iOS
//
//  Created by Richard Christiansen on 2/10/19.
//  Copyright © 2019 Dream Team. All rights reserved.
//

import Foundation
import FirebaseStorage
import FirebaseAuth

class StorageManager {
    // Create a root reference
    let storage = Storage.storage(url:"gs://scrapchat-77d1f.appspot.com/")
    
    func uploadProfilePicture(image: Data) {
        //Uploads profile picture to database and sets a URL reference on the database
        
        let storageRef = storage.reference()
        let filePath = "/user/\(Auth.auth().currentUser!.uid)/\("userPhoto")"
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpg"
        storageRef.child(filePath).putData(image, metadata: metaData) {(metaData, error) in
            if let error = error {
               print(error.localizedDescription)
               return
            } else {
                storageRef.child(filePath).downloadURL(completion: { (url, error) in
                    if error != nil {
                        print(error!.localizedDescription)
                    } else {
                        let downloadURL = url!.absoluteString
                        DatabaseManager().updateData(key: "profilePicture", value: downloadURL)
                    }
                })
            }
        }
    }
    
    func getPicture(withReferenceURL: String) -> StorageReference {
        let storageRef = storage.reference(forURL: withReferenceURL)
        return storageRef
    }
}
