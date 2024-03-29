//
//  EventCell.swift
//  ScrapChat_iOS
//
//  Created by Jaiden Chicote on 1/10/19.
//  Copyright © 2019 Dream Team. All rights reserved.
//

import Foundation
import UIKit

protocol EventDelegate {
    func onEditEvent(event: EventsObject)
}

class EventCell : UICollectionViewCell {
    
    @IBOutlet var dayOTWLabel: UILabel!
    @IBOutlet var DateLabel: UILabel!
    @IBOutlet var ddescriptionLabel: UILabel!
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var locationLabel: UILabel!
    
    var eventObject: EventsObject!
    var eventDelegate: EventDelegate?
    
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
    
    @IBAction func pressEdit(_ sender: Any) {
        eventDelegate?.onEditEvent(event: eventObject)
    }
}
