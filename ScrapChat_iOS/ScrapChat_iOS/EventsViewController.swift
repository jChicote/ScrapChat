//
//  EventsViewController.swift
//  ScrapChat_iOS
//
//  Created by Jaiden Chicote on 14/9/19.
//  Copyright © 2019 Dream Team. All rights reserved.
//

import UIKit
//import FirebaseFirestore

class EventsViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var eventCollection: UICollectionView!
    
    //Array of calender days / data
    var gregorianCalendar: [String] = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
    var monthOfYear: [String] = ["January", "Febuary", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
    
    
    //this is all test data
    var daysOFTW: [String] = ["Wednesday", "Friday", "Sunday", "Thursday", "Saturday", "Friday"]
    var datesOFTW: [String] = ["2nd November", "4th November", "6th November", "10th November", "12th November", "6th November"]
    var tempDescription: [String] =
        ["Coffee with .......", "Dog walk with ....... ", "Visiting Park with .....", "Visting home of ....", "Dinner with......", "Conversation with ........" ]
    var tempTime: [String] =
        ["9:30 am", "4:00 pm", "2:35 pm", "11:15 am", "1:45 pm", "12:20 pm"]
    var location: [String] =
        ["The Coffee Shop", "Hyde park", "Plumpton park", "26 Wonder Street", "1 Private Drive", "Unity Mall"]
    
    let padding: CGFloat = 280
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //set date
        
        let date = Date()
        let calender = Calendar.current
        let currentDay = calender.component(.day, from: date)
        let currentMonth = calender.component(.month, from: date)
        monthLabel.text = String(monthOfYear[currentMonth-1].prefix(3))
        dayLabel.text = String(currentDay)
        
        //let database = DatabaseManager()
        //database.getData()
        
        eventCollection.delegate = self
        eventCollection.dataSource = self
        
        //setup layout
        let width = view.frame.width * 0.68
        let height = view.frame.height / 5
        let layout = eventCollection.collectionViewLayout as! UICollectionViewFlowLayout
        
        layout.itemSize = CGSize(width: width, height: height)
        layout.minimumLineSpacing = 20
        //layout.headerReferenceSize = CGSize(width: width, height: 80)
    }
    
    
}

extension EventsViewController {
    
    //This is for the cells
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return daysOFTW.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EventsViewCell", for: indexPath) as! EventCell
        cell.backgroundColor = .white
        cell.layer.masksToBounds = true
        cell.layer.cornerRadius = 10
        cell.dayOTWLabel.text = daysOFTW[indexPath.row]
        cell.DateLabel.text = datesOFTW[indexPath.row]
        cell.ddescriptionLabel.text = tempDescription[indexPath.row]
        cell.timeLabel.text = tempTime[indexPath.row]
        cell.locationLabel.text = location[indexPath.row]
        cell.layoutIfNeeded()
        return cell
    }
}
