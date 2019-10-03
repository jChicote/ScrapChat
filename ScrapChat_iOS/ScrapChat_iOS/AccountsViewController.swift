//
//  AccountsViewController.swift
//  ScrapChat_iOS
//
//  Created by Richard Christiansen on 2/10/19.
//  Copyright © 2019 Dream Team. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class AccountsViewController: UIViewController {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var suburbLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var interestsLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        profileImage.layer.cornerRadius = profileImage.frame.width/2
        profileImage.clipsToBounds = true
        updateData()
    }
    
    func updateData() {
        //Updates data while providing a default value in case of nil value
        let database = DatabaseManager()
        //Updates name
        database.getData("firstname") { (data) in
            self.nameLabel.text = data! + " "
            database.getData("lastname") { (data) in
                 self.nameLabel.text! += data!
            }
        }
        //Updates gender
        database.getData("gender") { (data) in
            self.genderLabel.text = data ?? ""
        }
        //Updates location
        database.getData("suburb") { (data) in
            self.suburbLabel.text = data ?? ""
        }
        //Updates email address
        self.emailLabel.text = Auth.auth().currentUser?.email
        //Updates gender
        database.getData("interest") { (data) in
            self.interestsLabel.text = data ?? ""
        }
        //profileImage.image =
    }
    
    func updateImage() {
        let database = DatabaseManager()
        database.getData("profilePicture"){ (data) in
            if data != nil {
                print("Image loaded")
                //profileImage.sdImage
            }
        }
    }
    
    /*Segues*/
    @IBAction func friendsPressed(_ sender: UIButton) {
       let storyboard = UIStoryboard(name: "FriendsStoryboard", bundle: nil)
        let HomeVC = storyboard.instantiateViewController(withIdentifier: Constants.Storyboard.FriendsVC)
       UIApplication.shared.keyWindow?.rootViewController = HomeVC
    }
    
    @IBAction func backPressed(_ sender: UIButton) {
       let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let HomeVC = storyboard.instantiateViewController(withIdentifier: Constants.Storyboard.HomeVC)
       UIApplication.shared.keyWindow?.rootViewController = HomeVC
    }
}

extension AccountsViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBAction func picturePressed(_ sender: Any) {
        showImagePickerController()
        /*guard let image = profileImage.image, let data = image.jpegData(compressionQuality: 1.0) else {
            //present alert
            //print(data)
            return
        }
        
        let imageName = UUID().uuidString*/
    }
    
    /*func showImagePickerControllerActionSheet() {
        let photoLibrary = UIAlertAction(title: "Choose from library", style: .default) { action) in
            self.showImagePickerController(sourceType: .photoLibrary)
        }
    }*/
    
    func showImagePickerController() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        imagePickerController.sourceType = .photoLibrary
        //present(imagePickerController, animated: true, completion: nil)
        self.show(imagePickerController, sender: self)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let storage = StorageManager()
        if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            var data = Data()
            data = image.jpegData(compressionQuality: 0.8)!
            storage.uploadProfilePicture(image: data)
        } else if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            var data = Data()
            data = image.jpegData(compressionQuality: 0.8)!
            storage.uploadProfilePicture(image: data)
        }
        dismiss(animated: true, completion: nil)
        updateImage()
    }
}

