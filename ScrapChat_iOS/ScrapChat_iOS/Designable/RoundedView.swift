//
//  RoundedView.swift
//  ScrapChat_iOS
//
//  Created by Jaiden Chicote on 27/9/19.
//  Copyright © 2019 Dream Team. All rights reserved.
//

import UIKit

@IBDesignable
class RoundedView : UIView {
    //Variable is editable through teh attributes on the storyboard
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
}
