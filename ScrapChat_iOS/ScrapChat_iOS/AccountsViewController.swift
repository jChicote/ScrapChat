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
    
    override func viewWillAppear(_ animated: Bool) {
        updateData()
        updateImage()
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
        self.profileImage.layer.cornerRadius = self.profileImage.frame.size.width / 2
        profileImage.layer.masksToBounds = true
        profileImage.clipsToBounds = true
    }
    
    /*Segues*/
    @IBAction func friendsPressed(_ sender: UIButton) {
       let storyboard = UIStoryboard(name: "FriendsStoryboard", bundle: nil)
       let VC = storyboard.instantiateViewController(withIdentifier: Constants.Storyboard.FriendsVC)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
       appDelegate.window!.rootViewController = VC
       appDelegate.window!.makeKeyAndVisible()
    }
    
    @IBAction func backPressed(_ sender: UIButton) {
       let storyboard = UIStoryboard(name: "Main", bundle: nil)
       let VC = storyboard.instantiateViewController(withIdentifier: Constants.Storyboard.HomeVC)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
       appDelegate.window!.rootViewController = VC
       appDelegate.window!.makeKeyAndVisible()
    }
    
    @IBAction func unwindToAccounts(_ sender: UIStoryboardSegue) {}
}

extension AccountsViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBAction func picturePressed(_ sender: Any) {
        showImagePickerController()
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
        present(imagePickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let storage = StorageManager()
        if let pic = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            storage.uploadProfilePicture(image: storage.generateImageDataFrom(pic))
        } else if let pic = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            storage.uploadProfilePicture(image: storage.generateImageDataFrom(pic))
        }
        dismiss(animated: true, completion: nil)
        updateImage()
    }
}

