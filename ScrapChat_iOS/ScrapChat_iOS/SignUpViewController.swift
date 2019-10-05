//
//  SignUpViewController.swift
//  ScrapChat_iOS
//
//  Created by Richard James on 22/9/19.
//  Copyright © 2019 Dream Team. All rights reserved.
//

import UIKit
import FirebaseAuth

class SignUpViewController: VCKeyboardHandler, UITextFieldDelegate {
    
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
        dobTF.delegate = self
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let char = string.cString(using: String.Encoding.utf8)
        let isBackSpace = strcmp(char, "\\b")
        let maxRange = 7
        if textField == dobTF {

            // check the chars length dd -->2 at the same time calculate the dd-MM --> 5
            if (dobTF?.text?.count == 2) || (dobTF?.text?.count == 5) {
                //Handle backspace being pressed
                if !(string == "") {
                    // append the text
                    dobTF?.text = (dobTF?.text)! + "/"
                }
            }
            if isBackSpace == -92 {
                dobTF?.text = String((dobTF.text?.dropLast())!)
            }
            
            // check the condition not exceed 8 chars
            return !(textField.text!.count > maxRange)
        }
        else {
            return true
        }
    }
    
    override func textFieldShouldReturn(_ textField: UITextField) -> Bool {
       let nextTag = textField.tag + 1
        // Try to find next responder
        let nextResponder = textField.superview?.viewWithTag(nextTag)

        if nextResponder != nil {
            // Found next responder, so set it
            nextResponder?.becomeFirstResponder()
        } else {
            // Not found, so remove keyboard
            textField.resignFirstResponder()
        }

        return false
    }
    
    func validateInput() -> String? {
        
        if emailTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || passwordTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || firstNameTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            dobTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            lastNameTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || genderTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "Please enter all fields"
        }
        
        if dobTF.text?.trimmingCharacters(in: .whitespacesAndNewlines).count != 8 {
            return "Please enter a valid date in DD/MM/YY format"
        }
        
        let emailValidity = validateEmail()
        if emailValidity != "" {
            return emailValidity
        }
        
        if (passwordTF.text?.trimmingCharacters(in: .whitespacesAndNewlines).count)! < 6 {
            return "Password must be at least 6 characters long"
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
        if let vc = segue.destination as? QuestionnaireViewController {
                vc.newUser = self.user
        }
    }
    
    func showError(_ message: String) {
        errorLabel.text = message
        errorLabel.alpha = 1
    }
}
