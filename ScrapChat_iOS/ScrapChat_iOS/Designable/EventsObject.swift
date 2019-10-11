//
//  EventsObject.swift
//  ScrapChat_iOS
//
//  Created by Jaiden Chicote on 11/10/19.
//  Copyright © 2019 Dream Team. All rights reserved.
//

import Foundation

class EventsObject {
    
    var dayOfTheWeek: String
    var dateTime: String
    var amPM: String
    var description: String
    var location: String
    var person: Person
    
    init(dayOTW: String, dateTime: String, amPM: String, description: String, location: String, person: Person) {
        self.dayOfTheWeek = dayOTW
        self.dateTime = dateTime
        self.amPM = amPM
        self.description = description
        self.location = location
        self.person = person
    }
}
