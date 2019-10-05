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
    
    /*func showAlert(_ message: String, withHeader: String) {
        let alertController = UIAlertController(title: withHeader, message:
            message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
        self.present(alertController, animated: true, completion: nil)
    }*/
    
    func validateCredentials(completion: @escaping (Bool) -> Void) {
           let credential = EmailAuthProvider.credential(withEmail: (Auth.auth().currentUser?.email)!, password: (currentPasswordTF.text?.trimmingCharacters(in: .whitespacesAndNewlines))!)
           Auth.auth().currentUser?.reauthenticate(with: credential, completion: { (result, error) in
               if result != nil {
                   completion(true)
               } else {
                   completion(false)
               }
               
           })
       }
    
    func validateInput() -> Bool {
        let currentPassword = currentPasswordTF.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let newPassword = newPasswordTF.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let confirmPassword = confirmPasswordTF.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if  currentPassword == "" || newPassword == "" ||  confirmPassword == "" {
            showAlert("Please fill in all required fields", withHeader: "Error")
            print("not full")
            return false
        }
        
        if newPassword != confirmPassword {
            self.showAlert("The re-entered password is different from the new password." , withHeader: "Error")
            print("diff pass")
            return false
        }
        return true
    }

    @IBAction func confirmPressed(_ sender: Any) {
        let newPassword = newPasswordTF.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        if validateInput() == false {
            print("not validated")
            return
        } else {
            validateCredentials(completion: { (isValidated) in
                if isValidated == false {
                    self.showAlert("Wrong password", withHeader: "Error")
                    print("wrong pass")
                }
                else {
                    //Changes password value
                    Auth.auth().currentUser?.updatePassword(to: newPassword!, completion: { (error) in
                        if error == nil {
                            self.performSegue(withIdentifier: "unwindToAccounts", sender: self)
                        }
                    })
                }
            })
        }
    }

    /*Segues*/
       @IBAction func friendsPressed(_ sender: UIButton) {
          let storyboard = UIStoryboard(name: "FriendsStoryboard", bundle: nil)
          let vc = storyboard.instantiateViewController(withIdentifier: Constants.Storyboard.FriendsVC)
          self.navigationController?.pushViewController(vc, animated: false)
       }
}
