//
//  FriendCell.swift
//  ScrapChat_iOS
//
//  Created by Jaiden Chicote on 29/9/19.
//  Copyright © 2019 Dream Team. All rights reserved.
//

import Foundation
import UIKit

class FriendCell : UICollectionViewCell {
    
    @IBOutlet var cellLabel: UILabel!
    @IBOutlet var cellImage: UIImageView!
    @IBOutlet var cellView: UIView!
    
    /*override init(frame: CGRect) {
        super.init(frame: .zero)
        
        cellLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        cellLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        
        cellImage.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        cellImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        cellImage.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.7).isActive = true
    }*/
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        //translatesAutoresizingMaskIntoConstraints = false
        
        
        //cellView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        //cellLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        /*cellImage.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        cellImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        cellImage.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.7).isActive = true*/
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
        
        
        //cellLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        //cellLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        
    }
    
    /*required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }*/
}
