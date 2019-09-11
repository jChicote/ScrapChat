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
    
    var isExpanded = false
    var oneButtonCenter: CGPoint!
    var groupButtonCenter: CGPoint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        oneButtonCenter = asOne.center
        groupButtonCenter = asGroup.center
        
        asOne.center = callButton.center
        print(asOne.center)
        asGroup.center = callButton.center
        print(asGroup.center)

    }

    @IBAction func expandClicked(_ sender: UIButton) {
        if isExpanded == false {
            UIView.animate(withDuration: 0.3, animations: {
                sender.backgroundColor = UIColor(red: 5/255, green: 194/255, blue: 180/255, alpha: 1)
                self.asOne.center = self.oneButtonCenter
                self.asGroup.center = self.groupButtonCenter
            })
            isExpanded = true
        } else if isExpanded == true {
            UIView.animate(withDuration: 0.3, animations: {
                sender.backgroundColor = UIColor(red: 0, green: 255/255, blue: 138/255, alpha: 1)
                self.asOne.center = self.callButton.center
                self.asGroup.center = self.callButton.center
            })
            isExpanded = false
        }
    }
    
}

