//
//  QuestionnaireViewController.swift
//  ScrapChat_iOS
//
//  Created by Richard Christiansen on 1/10/19.
//  Copyright © 2019 Dream Team. All rights reserved.
//

import UIKit
import FirebaseAuth

class QuestionnaireViewController: VCKeyboardHandler {
    
    @IBOutlet weak var imagePickerBtn: RoundRectButton!
    @IBOutlet weak var suburbTF: UITextField!
    @IBOutlet weak var interestTF: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    var newUser = User()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        errorLabel.alpha = 0
        imagePickerBtn.layer.borderWidth = 1
        imagePickerBtn.layer.borderColor = UIColor.black.cgColor
    }
    
    override func viewDidLayoutSubviews() {
        //This gets called everytime the subview layout is changed. Sets the image corners to be perfectly rounded
        self.profileImage.layer.cornerRadius = self.profileImage.frame.height / 2
        profileImage.layer.masksToBounds = true
        profileImage.clipsToBounds = true
    }
    
    func validateInput() -> String? {
        if suburbTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || interestTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "Please enter all fields"
        }
        
        return nil
    }
    
    @IBAction func donePressed(_ sender: Any) {
        let errorMess = validateInput()
        guard errorMess == nil else {
            showError(errorMess!)
            return
        }
        
        let suburb = suburbTF.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let interest = interestTF.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        
        Auth.auth().createUser(withEmail: newUser.email!, password: newUser.password!) { (result, error) in
            if error != nil {
                self.showError("Account was not successfully created.")
                print(error!.localizedDescription)
            }
            else {
                if !DatabaseManager().createAccount(firstName: self.newUser.firstName!, lastName: self.newUser.lastName!, gender: self.newUser.gender!, dateOfBirth: self.newUser.dateOfBirth!, suburb: suburb!, interest: interest!, userID: result!.user.uid) {
                    self.showError("Data was not successfully created")
                }
                else {
                    DatabaseManager().updateLastLoggedIn()
                    let storage = StorageManager()
                    if self.profileImage.image != UIImage(named: "Portrait Placeholder.png")
                    {
                        storage.uploadProfilePicture(image: storage.generateImageDataFrom(self.profileImage.image!)) {(uploadStatus) in
                            if uploadStatus == true {
                                self.transitionToHome()
                            }
                            else {
                                self.showAlert("Please try again later.", withHeader: "Upload failed", completion: {_ in
                                    self.transitionToHome()
                                })
                            }
                        }
                    }
                }
            }
        }
    }
    
    func showError(_ message: String) {
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    
    func transitionToHome() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let HomeVC = storyboard.instantiateViewController(withIdentifier: Constants.Storyboard.HomeVC)
        self.navigationController?.pushViewController(HomeVC, animated: true)
    }

}

extension QuestionnaireViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBAction func uploadPicturePressed(_ sender: Any) {
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
        if let pic = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            profileImage.image = pic
        } else if let pic = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            profileImage.image = pic
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
