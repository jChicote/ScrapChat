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
    
    var user = User()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        errorLabel.alpha = 0
    }
    
    func validateInput() -> String? {
        
        if emailTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || passwordTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || firstNameTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || lastNameTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || genderTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "Please enter all fields"
        }
        
        let emailValidity = validateEmail()
        if emailValidity != "" {
            return emailValidity
        }
        
        if (passwordTF.text?.trimmingCharacters(in: .whitespacesAndNewlines).count)! < 6 {
            return "Password must be 6 characters long or more"
        }
        return nil
        // TODO: validate email regex
    }
    
    func validateEmail() -> String {
        //let email = emailTF.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        //var isValidated: Bool = false
        let message: String = ""
        return message
    }
    
    @IBAction func nextPressed(_ sender: UIButton) {
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
        
        user = User(firstName: firstName!, lastName: lastName!, email: email!, password: password!, gender: gender!, dateOfBirth: dateOfBirth!)
        performSegue(withIdentifier: "questionnaireSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! QuestionnaireViewController
        vc.newUser = self.user
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
