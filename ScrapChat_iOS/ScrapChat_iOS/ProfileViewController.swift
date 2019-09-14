//
//  ProfileViewController.swift
//  ScrapChat_iOS
//
//  Created by Jaiden Chicote on 14/9/19.
//  Copyright © 2019 Dream Team. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var profileCenterConstraint: NSLayoutConstraint!
    @IBOutlet weak var profilePop: UIView!
    @IBOutlet weak var backButton: RoundRectButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profilePop.layer.cornerRadius = 20
        profilePop.layer.masksToBounds = true
        
        onEnter()
    }
    
    @IBAction
    
    func onEnter() {
        profileCenterConstraint.constant = 0
        
        UIView.animate(withDuration: 0.8, animations: {
            self.view.layoutIfNeeded()
        })
    }
    
    @IBAction func closeProfile(_ sender: Any) {
        profileCenterConstraint.constant = 1500
        UIView.animate(withDuration: 1.2, animations: {
            self.view.layoutIfNeeded()
        })
        dismiss(animated: true, completion: nil)
    }

}
