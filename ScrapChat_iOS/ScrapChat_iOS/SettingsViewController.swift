//
//  SettingsViewController.swift
//  ScrapChat_iOS
//
//  Created by Jaiden Chicote on 14/9/19.
//  Copyright © 2019 Dream Team. All rights reserved.
//

import UIKit
import FirebaseAuth

class SettingsViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func logoutPressed(_ sender: UIButton) {
        try! Auth.auth().signOut()
        let storyboard = UIStoryboard(name: "Login", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: Constants.Storyboard.LoginVC)
        self.navigationController?.pushViewController(vc, animated: false)
    }
    /*override func didRecieveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }*/
    
    @IBAction func exitTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
