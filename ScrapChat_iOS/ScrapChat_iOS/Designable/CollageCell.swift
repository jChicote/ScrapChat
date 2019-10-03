//
//  CollageCell.swift
//  ScrapChat_iOS
//
//  Created by Jaiden Chicote on 3/10/19.
//  Copyright © 2019 Dream Team. All rights reserved.
//

import Foundation
import UIKit

class CollageCell : UICollectionViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            contentView.leftAnchor.constraint(equalTo: leftAnchor),
            contentView.rightAnchor.constraint(equalTo: rightAnchor),
            contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
    }
}
