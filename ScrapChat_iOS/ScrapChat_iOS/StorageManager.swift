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
    let storageRef = Storage.storage(url:"gs://scrapchat-77d1f.appspot.com/").reference()
    
    func generateImageDataFrom(_ image: UIImage) -> Data {
        let data = image.jpegData(compressionQuality: 0.8)
        return data!
    }
    
    func uploadProfilePicture(image: Data, completion: @escaping (Bool?) -> Void) {
        //Uploads profile picture to database and sets a URL reference on the database
        ActivityIndicator().startActivity()
        let filePath = "/user/\(Auth.auth().currentUser!.uid)/\("userPhoto")"
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpg"
        storageRef.child(filePath).putData(image, metadata: metaData) {(metaData, error) in
            if let error = error {
               print(error.localizedDescription)
               completion(false)
               ActivityIndicator().stopActivity()
            } else {
                self.storageRef.child(filePath).downloadURL(completion: { (url, error) in
                    if error != nil {
                        print(error!.localizedDescription)
                        ActivityIndicator().stopActivity()
                    } else {
                        let downloadURL = url!.absoluteString
                        DatabaseManager().updateData(key: "profilePicture", value: downloadURL)
                        completion(true)
                        ActivityIndicator().stopActivity()
                    }
                })
            }
        }
    }
    
    func uploadPicture(image: Data, withName: String) {
        let filePath = "/user/\(Auth.auth().currentUser!.uid)/scrapbooks/\(withName)"
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpg"
        metaData.contentType = "image/jpg"
        storageRef.child(filePath).putData(image, metadata: metaData) {(metaData, error) in
            if let error = error {
               print(error.localizedDescription)
               return
            } else {
                self.storageRef.child(filePath).downloadURL(completion: { (url, error) in
                    if error != nil {
                        print(error!.localizedDescription)
                    } else {
                        let downloadURL = url!.absoluteString
                        //@Jaiden: Atm the URL reference is still not used
                    }
                })
            }
        }
    }
    
    func getPicture(withReferenceURL: String) -> StorageReference {
        let pictureStorageRef = Storage.storage().reference(forURL: withReferenceURL)
        return pictureStorageRef
    }
}
