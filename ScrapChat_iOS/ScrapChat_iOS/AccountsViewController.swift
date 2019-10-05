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
import SDWebImage

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
    
    override func viewDidAppear(_ animated: Bool) {
        profileImage.setNeedsDisplay()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        updateData()
        updateImage()
        
    }
    
    override func viewDidLayoutSubviews() {
        //This gets called everytime the subview layout is changed. Sets the image corners to be perfectly rounded
        self.profileImage.layer.cornerRadius = self.profileImage.frame.height / 2
        profileImage.layer.masksToBounds = true
        profileImage.clipsToBounds = true
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
    }
    
    func updateImage() {
        //Updates image view with profile image from the database
        let database = DatabaseManager()
        database.getData("profilePicture"){ (url) in
            if url != nil {
                self.profileImage.sd_setImage(with: URL(string: url!),
                                              placeholderImage: UIImage(named: "Portrait Placeholder.png"),
                                              options: SDWebImageOptions.highPriority,
                                              progress: nil,
                                              completed: nil)
            }
        }
    }
    
    /*Segues*/
    @IBAction func friendsPressed(_ sender: UIButton) {
       let storyboard = UIStoryboard(name: "FriendsStoryboard", bundle: nil)
       let vc = storyboard.instantiateViewController(withIdentifier: Constants.Storyboard.FriendsVC)
       self.navigationController?.pushViewController(vc, animated: false)
    }
    
    /*@IBAction func backPressed(_ sender: UIButton) {
       let storyboard = UIStoryboard(name: "Main", bundle: nil)
       let vc = storyboard.instantiateViewController(withIdentifier: Constants.Storyboard.HomeVC)
       self.navigationController?.pushViewController(vc, animated: false)
    }*/
    
    @IBAction func unwindToAccounts(_ sender: UIStoryboardSegue) {}
}

extension AccountsViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBAction func picturePressed(_ sender: Any) {
        showImagePickerController()
    }
    
    func showImagePickerController() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        
        let actionSheet = UIAlertController(title: "Photo Source", message: "Choose a source", preferredStyle: .actionSheet)
        
        if let popoverController = actionSheet.popoverPresentationController {
          popoverController.sourceView = self.view
           popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
            popoverController.permittedArrowDirections = []
          }
        
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action:UIAlertAction) in
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                imagePickerController.sourceType = .camera
                self.present(imagePickerController, animated: true, completion: nil)
            }
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: {(action:UIAlertAction) in
            imagePickerController.sourceType = .photoLibrary
            self.present(imagePickerController, animated: true, completion: nil)
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let storage = StorageManager()
        if let pic = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            storage.uploadProfilePicture(image: storage.generateImageDataFrom(pic)) {(uploadStatus) in
                if uploadStatus == true {
                    self.updateImage()
                }
                else {
                    self.showAlert("Please try again later.", withHeader: "Upload failed")
                }
            }
        } else if let pic = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            storage.uploadProfilePicture(image: storage.generateImageDataFrom(pic)) {(uploadStatus) in
                if uploadStatus == true {
                    self.updateImage()
                }
                else {
                    self.showAlert("Please try again later.", withHeader: "Upload failed")
                }
            }
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

