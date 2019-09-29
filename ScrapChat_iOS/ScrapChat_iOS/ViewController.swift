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
    
    
}

