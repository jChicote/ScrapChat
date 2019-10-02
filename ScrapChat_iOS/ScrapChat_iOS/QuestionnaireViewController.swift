//
//  QuestionnaireViewController.swift
//  ScrapChat_iOS
//
//  Created by Richard Christiansen on 1/10/19.
//  Copyright © 2019 Dream Team. All rights reserved.
//

import UIKit
import FirebaseAuth

class QuestionnaireViewController: UIViewController {
    
    @IBOutlet weak var imagePickerBtn: RoundRectButton!
    @IBOutlet weak var suburbTF: UITextField!
    @IBOutlet weak var interestTF: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    //var email, firstName, lastName, gender : String
    //var dateOfBirth : String
    var newUser = User()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        errorLabel.alpha = 0
        imagePickerBtn.layer.borderWidth = 1
        imagePickerBtn.layer.borderColor = UIColor.gray.cgColor
        print(newUser.email!)
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
                    self.transitionToHome()
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
        present(HomeVC, animated: true, completion: nil)
    }
}
