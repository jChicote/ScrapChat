//
//  scrapObject.swift
//  ScrapChat_iOS
//
//  Created by Jaiden Chicote on 5/10/19.
//  Copyright © 2019 Dream Team. All rights reserved.
//

import Foundation
import UIKit

class ScrapObject{
    
    var collage : UIImage
    var date : Date
    var partner : Person
    
    init(collage: UIImage, date: Date, partner: Person) {
        self.collage = collage
        self.date = date
        self.partner = partner
    }
}
