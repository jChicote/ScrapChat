//
//  ViewController.swift
//  ScrapChat_iOS
//
//  Created by Jaiden Chicote on 10/9/19.
//  Copyright © 2019 Dream Team. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var asOne: UIButton!
    @IBOutlet weak var asGroup: UIButton!
    @IBOutlet weak var callButton: UIButton!
    @IBOutlet weak var backgroundButton: UIButton!
    @IBOutlet weak var settingBackButton: UIButton!
    
    //note modal popouts should be used with care
    @IBOutlet weak var profileBackground: UIButton!
    @IBOutlet weak var profilePopView: UIView!
    @IBOutlet weak var profileBackButton: UIButton!
    
    //Constraints
    @IBOutlet weak var profileYConstraint: NSLayoutConstraint!
    @IBOutlet weak var settingXConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var SettingsViewPop: UIView!
    
    var isExpanded = false
    var oneButtonCenter: CGPoint!
    var groupButtonCenter: CGPoint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        asOne.isHidden = true
        asGroup.isHidden = true
        profilePopView.layer.cornerRadius = 20
        profilePopView.layer.masksToBounds = true

    }
    
    //Needs to use viewDidRender due to the load cycle
    override func viewDidAppear(_ animated: Bool) {
        oneButtonCenter = asOne.center
        groupButtonCenter = asGroup.center
        
        asOne.center = callButton.center
        print(asOne.center)
        asGroup.center = callButton.center
        print(asGroup.center)
    }

    //this is especially for the call button
    @IBAction func expandClicked(_ sender: UIButton) {
        asOne.isHidden = false
        asGroup.isHidden = false
        if isExpanded == false {
             UIView.animate(withDuration: 0.5, animations: {
                self.asOne.center = self.oneButtonCenter
                print("Has been pressed")
            })
            
            UIView.animate(withDuration: 0.6, animations: {
                sender.backgroundColor = UIColor(red: 5/255, green: 194/255, blue: 180/255, alpha: 1)
                self.backgroundButton.alpha = 0.5
                self.asGroup.center = self.groupButtonCenter
            })
            
            isExpanded = true
            
        } else if isExpanded == true {
            UIView.animate(withDuration: 0.3, animations: {
                self.callButton.backgroundColor = UIColor(red: 0, green: 255/255, blue: 138/255, alpha: 1)
                self.asOne.center = self.callButton.center
                self.asGroup.center = self.callButton.center
                self.backgroundButton.alpha = 0
            })
            isExpanded = false
        }
    }
    
    @IBAction func collapseClicked(_ sender: Any) {
        
        UIView.animate(withDuration: 0.3, animations: {
            self.backgroundButton.alpha = 0
            self.callButton.backgroundColor = UIColor(red: 0, green: 255/255, blue: 138/255, alpha: 1)
            self.asOne.center = self.callButton.center
            self.asGroup.center = self.callButton.center
        })
        isExpanded = false
    }
    
    @IBAction func profileOpen(_ sender: UIButton) {
        self.profileYConstraint.constant = 0
        UIView.animate(withDuration: 0.3, animations: {
            self.profileBackground.alpha = 0.8
            self.view.layoutIfNeeded()
            self.centerCallButtons()
        })
    }
    
    @IBAction func profileClose(_ sender: Any) {
        self.profileYConstraint.constant = 1500
        UIView.animate(withDuration: 0.3, animations: {
            self.profileBackground.alpha = 0
            self.view.layoutIfNeeded()
            self.centerCallButtons()
        })
    }
    
    @IBAction func openSettings(_ sender: UIButton) {
        self.settingXConstraint.constant = 291
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
            self.settingBackButton.alpha = 0.7
            self.centerCallButtons()
        })
    }
    
    @IBAction func closeSettings(_ sender: Any) {
        self.settingXConstraint.constant = -500
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
            self.settingBackButton.alpha = 0
            self.centerCallButtons()
        })
    }
    
    /*NOTE: This is only used because updating
            subview layout causes the main view
            layout to also updating removing
            default centering of buttons
            established during viewload cycle. */
    func centerCallButtons() {
        self.asOne.center = self.callButton.center
        self.asGroup.center = self.callButton.center
    }
    
}

