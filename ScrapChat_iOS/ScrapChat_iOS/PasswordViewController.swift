//
//  PasswordViewController.swift
//  ScrapChat_iOS
//
//  Created by Richard Christiansen on 3/10/19.
//  Copyright © 2019 Dream Team. All rights reserved.
//

import UIKit
import FirebaseAuth

class PasswordViewController: UIViewController {

    @IBOutlet weak var currentPasswordTF: UITextField!
    @IBOutlet weak var newPasswordTF: UITextField!
    @IBOutlet weak var confirmPasswordTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func showAlert(_ message: String, withHeader: String) {
        let alertController = UIAlertController(title: withHeader, message:
            "Hello, world!", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
        self.present(alertController, animated: true, completion: nil)
    }
    
    func validateCredentials(completion: @escaping (Bool) -> Void) {
           let credential = EmailAuthProvider.credential(withEmail: (Auth.auth().currentUser?.email)!, password: (currentPasswordTF.text?.trimmingCharacters(in: .whitespacesAndNewlines))!)
           Auth.auth().currentUser?.reauthenticate(with: credential, completion: { (result, error) in
               if error != nil {
                   completion(true)
               } else {
                   completion(false)
               }
               
           })
       }
    
    func validateInput() {
        let currentPassword = currentPasswordTF.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let newPassword = newPasswordTF.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let confirmPassword = confirmPasswordTF.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if  currentPassword == "" || newPassword == "" ||  confirmPassword == "" {
            showAlert("Please fill in all required fields", withHeader: "Error")
            return
        }
        
        validateCredentials(completion: { (isValidated) in
            if isValidated == false {
                self.showAlert("Wrong password", withHeader: "Error")
            }
        })
        
        if newPassword != confirmPassword {
            self.showAlert("The re-entered password is different from the new password." , withHeader: "Error")
        }
    }

    @IBAction func confirmPressed(_ sender: Any) {
        let newPassword = newPasswordTF.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        Auth.auth().currentUser?.updatePassword(to: newPassword!, completion: { (error) in
            if error == nil {
                self.performSegue(withIdentifier: "unwindAccount", sender: self)
            }
        })
    }

}
