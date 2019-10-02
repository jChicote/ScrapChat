//
//  StorageManager.swift
//  ScrapChat_iOS
//
//  Created by Richard Christiansen on 2/10/19.
//  Copyright © 2019 Dream Team. All rights reserved.
//

import Foundation
import FirebaseStorage

class StorageManager {
    // Create a root reference
    let storage = Storage.storage(url:"gs://scrapchat-77d1f.appspot.com/")
    
    func uploadImage(imagePath: String) {
        //let storageRef = storage.reference()
    }
    // Create a reference to "mountains.jpg"
    //let mountainsRef = storageRef.child("mountains.jpg")

    // Create a reference to 'images/mountains.jpg'
    //let mountainImagesRef = storageRef.child("images/mountains.jpg")

    // While the file names are the same, the references point to different files
    //mountainsRef.name == mountainImagesRef.name;            // true
    //mountainsRef.fullPath == mountainImagesRef.fullPath;    // false
}
