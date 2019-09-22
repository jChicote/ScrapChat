//
//  EventsViewController.swift
//  ScrapChat_iOS
//
//  Created by Jaiden Chicote on 14/9/19.
//  Copyright © 2019 Dream Team. All rights reserved.
//

import UIKit
import FirebaseFirestore
class EventsViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let database = DatabaseManager()
        database.getData()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
