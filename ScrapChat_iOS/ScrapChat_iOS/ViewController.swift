//
//  ViewController.swift
//  ScrapChat_iOS
//
//  Created by Jaiden Chicote on 10/9/19.
//  Copyright © 2019 Dream Team. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var backgroundButton: UIButton!
    @IBOutlet weak var settingBackButton: UIButton!
    @IBOutlet var mingleBackImage: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mingleBackImage.tintColor = #colorLiteral(red: 1, green: 0.7993489356, blue: 0, alpha: 1)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.mingleBackImage.tintColor = #colorLiteral(red: 1, green: 0.7993489356, blue: 0, alpha: 1)
    }
    
    //Needs to use viewDidRender due to the load cycle
    override func viewDidAppear(_ animated: Bool) {
        let cogStencil = UIImage(named: "settings_cog")?.withRenderingMode(.alwaysTemplate)
        settingBackButton.setImage(cogStencil, for: .normal)
        settingBackButton.tintColor = UIColor.gray
    }
    
    @IBAction func OnMingleTouch(_ sender: Any) {
        UIView.animate(withDuration: 0.1) {
            self.mingleBackImage.tintColor = #colorLiteral(red: 1, green: 0.6372304196, blue: 0, alpha: 1)
        }
    }
    
    @IBAction func accountsPressed(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Accounts", bundle: nil)
        let HomeVC = storyboard.instantiateViewController(withIdentifier: Constants.Storyboard.AccountsVC)
        UIApplication.shared.keyWindow?.rootViewController = HomeVC
    }
    
    @IBAction func friendsPressed(_ sender: UIButton) {
       let storyboard = UIStoryboard(name: "FriendsStoryboard", bundle: nil)
        let HomeVC = storyboard.instantiateViewController(withIdentifier: Constants.Storyboard.FriendsVC)
       UIApplication.shared.keyWindow?.rootViewController = HomeVC
    }
    
    @IBAction func UnwindToHome(_ sender: UIStoryboardSegue) {}
    
    
}

