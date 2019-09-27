//
//  ViewController.swift
//  ScrapChat_iOS
//
//  Created by Jaiden Chicote on 10/9/19.
//  Copyright © 2019 Dream Team. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var callButton: UIButton!
    @IBOutlet weak var backgroundButton: UIButton!
    @IBOutlet weak var settingBackButton: UIButton!
    
    var isExpanded = false
    var oneButtonCenter: CGPoint!
    var groupButtonCenter: CGPoint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

    }
    
    //Needs to use viewDidRender due to the load cycle
    override func viewDidAppear(_ animated: Bool) {
        let cogStencil = UIImage(named: "settings_cog")?.withRenderingMode(.alwaysTemplate)
        settingBackButton.setImage(cogStencil, for: .normal)
        settingBackButton.tintColor = UIColor.gray
    }
    
}

