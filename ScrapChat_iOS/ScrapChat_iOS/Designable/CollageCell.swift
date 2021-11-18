//
//  CollageCell.swift
//  ScrapChat_iOS
//
//  Created by Jaiden Chicote on 3/10/19.
//  Copyright © 2019 Dream Team. All rights reserved.
//

import Foundation
import UIKit

protocol CollageCellDelegate {
    func didTapCell(pImage: UIImage)
}

class CollageCell : UICollectionViewCell {
    
    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var date: UILabel!
    
    var delegateCell: CollageCellDelegate?
    
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
    
    @IBAction func viewPhoto(_ sender: Any) {
        delegateCell?.didTapCell(pImage: thumbnail.image!)
    }
}
