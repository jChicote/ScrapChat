//
//  AccountsViewController.swift
//  ScrapChat_iOS
//
//  Created by Richard Christiansen on 2/10/19.
//  Copyright © 2019 Dream Team. All rights reserved.
//

import UIKit
import FirebaseAuth

class AccountsViewController: UIViewController {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var suburbLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var interestsLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profileImage.layer.cornerRadius = profileImage.frame.width/2
        profileImage.clipsToBounds = true
        updateData()
    }
    
    func updateData() {
        let database = DatabaseManager()
        //Updates name
        database.getData("firstname") { (data) in
            self.nameLabel.text = data + " "
            database.getData("lastname") { (data) in
                 self.nameLabel.text! += data
            }
        }
        
        //Updates gender
        database.getData("gender") { (data) in
            self.genderLabel.text = data
        }
        
        //Updates location
        database.getData("suburb") { (data) in
            self.suburbLabel.text = data
        }
        
        //Updates email address
        self.emailLabel.text = Auth.auth().currentUser?.email
        
        //Updates gender
        database.getData("interest") { (data) in
            self.interestsLabel.text = data
        }
        
        //profileImage.image =
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        self.navigationController?.popViewController(animated: false)
    }
}