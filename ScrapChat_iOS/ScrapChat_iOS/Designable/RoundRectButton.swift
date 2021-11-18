//
//  RoundRectButton.swift
//  ScrapChat_iOS
//
//  Created by Jaiden Chicote on 10/9/19.
//  Copyright © 2019 Dream Team. All rights reserved.
//

import UIKit

@IBDesignable
class RoundRectButton: UIButton {
    
    //Variable is editable through teh attributes on the storyboard
    @IBInspectable var cornerRadius: CGFloat = 15 {
        didSet {
            setRadiusCorner(value: cornerRadius)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupButton()
    }
    
    override func prepareForInterfaceBuilder() {
        setupButton()
    }
    
    func setupButton() {
        setRadiusCorner(value: cornerRadius)
    }
    
    func setRadiusCorner(value: CGFloat) {
        layer.cornerRadius = value
    }
    
    
}
