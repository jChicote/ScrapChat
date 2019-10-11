//
//  FriendCell.swift
//  ScrapChat_iOS
//
//  Created by Jaiden Chicote on 29/9/19.
//  Copyright © 2019 Dream Team. All rights reserved.
//

import Foundation
import UIKit

protocol CellDelegate {
    func didTapCall(person: Person)
    func didTapEvent(person: Person)
}

class FriendCell : UICollectionViewCell {
    
    var individual: Person!
    @IBOutlet var cellLabel: UILabel!
    @IBOutlet var cellImage: UIImageView!
    
    var cellDelegate: CellDelegate?
 
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
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
    
    @IBAction func makeCallTapped(_ sender: Any) {
        cellDelegate?.didTapCall(person: individual)
    }
    
    @IBAction func makeEventTapped(_ sender: Any) {
        cellDelegate?.didTapEvent(person: individual)
    }
    
}
