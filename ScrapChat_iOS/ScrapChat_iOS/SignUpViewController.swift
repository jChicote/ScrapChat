//
//  SignUpViewController.swift
//  ScrapChat_iOS
//
//  Created by Richard James on 22/9/19.
//  Copyright © 2019 Dream Team. All rights reserved.
//

import UIKit
import FirebaseAuth

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var firstNameTF: UITextField!
    @IBOutlet weak var lastNameTF: UITextField!
    @IBOutlet weak var genderTF: UITextField!
    @IBOutlet weak var dobTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        errorLabel.alpha = 0
    }
    
    func validateInput() -> String? {
        
        if emailTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || passwordTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || firstNameTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || lastNameTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || genderTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "Please enter all fields"
        }
        
        if validateEmail() == false {
            return "Email is used?"
        }
        
        return nil
        // TODO: validate email regex
    }
    
    func validateEmail() -> Bool {
        let email = emailTF.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        var isValidated: Bool = false
        Auth.auth().fetchSignInMethods(forEmail: email!) { (providers, error) in
            if let error = error {
                print(error.localizedDescription)
                isValidated = false
            } else if let providers = providers {
                print(providers)
                isValidated = false
            }
            isValidated = true
        }
        return isValidated
    }
    
    @IBAction func createPressed(_ sender: UIButton) {
        //Input validation
        let errorMess = validateInput()
        guard errorMess == nil else {
            showError(errorMess!)
            return
        }
        
        let email = emailTF.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordTF.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let firstName = firstNameTF.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let lastName = lastNameTF.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let gender = genderTF.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let dateOfBirth = dobTF.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        
        var user = User(firstName: firstName!, lastName: lastName!, email: email!, password: password!, gender: gender!, dateOfBirth: dateOfBirth!)
        
            /*Auth.auth().createUser(withEmail: email!, password: password!) { (result, error) in
            if error != nil {
                self.showError("Account was not successfully created.")
                //print(error!.localizedDescription)
            }
            else {
                if !DatabaseManager().createAccount(firstName: firstName!, lastName: lastName!, gender: gender!, dateOfBirth: dateOfBirth!, userID: result!.user.uid) {
                    self.showError("Data was not successfully created")
                }
                else {
                    DatabaseManager().updateLastLoggedIn()
                    self.transitionToHome()
                }
            }
        }*/
    }
    
    func showError(_ message: String) {
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    
    /*override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        <#code#>
    }*/
    
    func transitionToHome() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let HomeVC = storyboard.instantiateViewController(withIdentifier: Constants.Storyboard.HomeVC)
        present(HomeVC, animated: true, completion: nil)
    }
}
