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
    }
    /*override func didRecieveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }*/

}
