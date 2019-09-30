//
//  LoginViewController.swift
//  ScrapChat_iOS
//
//  Created by Richard James on 22/9/19.
//  Copyright © 2019 Dream Team. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

        @IBOutlet weak var emailTF: UITextField!
        @IBOutlet weak var passwordTF: UITextField!
        @IBOutlet weak var errorLabel: UILabel!
        @IBOutlet weak var loginBtn: UIButton!
        
        override func viewDidLoad() {
            super.viewDidLoad()
            errorLabel.alpha = 0
            loginBtn.layer.cornerRadius = 10
        }
        
        @IBAction func backToLogin(_sender: UIStoryboardSegue) {}
        
        func validateInput() -> String? {
            
            if emailTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || passwordTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
                return "Please enter all fields"
            }
            else {
                return nil
            }
            
            // TODO: validate email regex
        }
        
        @IBAction func loginPressed(_ sender: UIButton) {
            //Input validation
            let errorMess = validateInput()
            guard errorMess == nil else {
                showError(errorMess!)
                return
            }
            
            let email = emailTF.text?.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTF.text?.trimmingCharacters(in: .whitespacesAndNewlines)
            
            Auth.auth().signIn(withEmail: email!, password: password!) { (result, error) in
                if error != nil {
                    //Sign in not successful
                    self.showError("Incorrect email or password.")
                    //print(error!.localizedDescription)
                }
                else {
                    DatabaseManager().updateLastLoggedIn()
                    self.transitionToHome()
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
            present(HomeVC, animated: true, completion: nil)
        }
    }
