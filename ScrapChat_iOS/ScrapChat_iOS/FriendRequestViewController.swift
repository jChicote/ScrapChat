//
//  FriendRequestViewController.swift
//  ScrapChat_iOS
//
//  Created by Jaiden Chicote on 6/10/19.
//  Copyright © 2019 Dream Team. All rights reserved.
//

import UIKit

class FriendRequestViewController: UIViewController {
    
    @IBOutlet weak var messageLabel: UILabel!
    var newFriend: Person?
    var friends = FriendManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        messageLabel.text = "Would you like to add \(newFriend!.name) as a friend?"
    }
    
    @IBAction func addFriend(_ sender: Any) {
        //friends.friendArray.insert(newFriend!, at: 0)
    }

}
