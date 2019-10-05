//
//  ForgotPasswordViewController.swift
//  ScrapChat_iOS
//
//  Created by Richard Christiansen on 5/10/19.
//  Copyright © 2019 Dream Team. All rights reserved.
//

import UIKit
import FirebaseAuth

class ForgotPasswordViewController: UIViewController {

    @IBOutlet weak var emailTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        let email = emailTF.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        if email != "" {
            sendPasswordEmailReset(email: email!)
        } else {
            showAlert("Please enter a valid email", withHeader: "Error")
        }
    }
    
    func sendPasswordEmailReset(email: String) {
        Auth.auth().sendPasswordReset(withEmail: email, completion: { (error) in
            self.showAlert("Please check your email inbox to complete password reset.", withHeader: "Password reset email sent", completion: {_ in
                self.performSegue(withIdentifier: "loginUnwind", sender: self)
            })
        })
    }
}
