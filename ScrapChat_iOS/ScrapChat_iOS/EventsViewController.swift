//
//  EventsViewController.swift
//  ScrapChat_iOS
//
//  Created by Jaiden Chicote on 14/9/19.
//  Copyright © 2019 Dream Team. All rights reserved.
//

import UIKit
//import FirebaseFirestore

class EventsViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var eventCollection: UICollectionView!
    @IBOutlet weak var mingleBack: UIImageView!
    
    //Event Outlet
    @IBOutlet weak var darkMode: UIView!
    @IBOutlet weak var friendPicker: UIPickerView!
    @IBOutlet weak var textDescription: UITextField!
    @IBOutlet weak var timePicker: UIDatePicker!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var eventView: UIView!
    
    //ConstraintOutlets
    @IBOutlet weak var editViewY: NSLayoutConstraint!
    
    //Array of calender days / data
    var gregorianCalendar: [String] = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
    var monthOfYear: [String] = ["January", "Febuary", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
    
    var personSelected: Person?
    var eventEdited: EventsObject?
    
    let padding: CGFloat = 280
    //let formatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        eventView.layer.cornerRadius = 20
        eventView.layer.masksToBounds = true
        
        //set date
        let calender = Calendar.current
        let date = Date()
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.mingleBack.tintColor = #colorLiteral(red: 0.8078431373, green: 0.7921568627, blue: 0.7921568627, alpha: 1)
    }
    
    @IBAction func onMingle(_ sender: Any) {
        UIView.animate(withDuration: 0.1) {
            self.mingleBack.tintColor = #colorLiteral(red: 1, green: 0.7993489356, blue: 0, alpha: 1)
        }
        
        let storyboard = UIStoryboard(name: "VideoChatScreen", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: Constants.Storyboard.ChatVC)
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    @IBAction func completeEvent(_ sender: Any) {
        editViewY.constant = 1500
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
            self.darkMode.alpha = 0
        }
        let arrayCopy = EventsManager.events
        let iteratedDateFormat = DateFormatter()
        iteratedDateFormat.dateFormat = "dd/MM/yyy-HH:mm"
        
        for position in 0..<arrayCopy.count {
            if eventEdited?.dateTime == arrayCopy[position].dateTime {
                EventsManager.events.remove(at: position)
            }
        }
        EventsManager.events.insert(eventEdited!, at: 1)
        
        let sortedEvents = EventsManager.events.sorted { iteratedDateFormat.date(from: $0.dateTime)! < iteratedDateFormat.date(from: $1.dateTime)!
        }
        EventsManager.events = sortedEvents
        eventCollection.reloadData()
    }
    
    @IBAction func onCancel(_ sender: Any) {
        editViewY.constant = 1500
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
            self.darkMode.alpha = 0
        }
    }
    
    @IBAction func onSetting(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: Constants.Storyboard.SettingVC)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func scrapbookTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "ScrapbookStoryboard", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: Constants.Storyboard.ScrapBookVC)
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    @IBAction func friendsTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "FriendsStoryboard", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: Constants.Storyboard.FriendsVC)
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    @IBAction func accountsTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Accounts", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: Constants.Storyboard.AccountsVC)
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
}

extension EventsViewController: EventDelegate {
    
    func onEditEvent(event: EventsObject) {
        editViewY.constant = 0
        
        eventEdited = event
        let editDateFormat = DateFormatter()
        editDateFormat.dateFormat = "dd/MM/yyyy"
        let date = editDateFormat.date(from: event.dateTime)
        datePicker.date = date ?? Date()
        
        editDateFormat.dateFormat = "HH:mm a"
        let time = editDateFormat.date(from: event.dateTime)
        timePicker.date = time ?? Date()
        
        textDescription.text = event.description
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
            self.darkMode.alpha = 0.8
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return FriendManager.friendArray[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return FriendManager.friendArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        personSelected = FriendManager.friendArray[row]
    }
}

extension EventsViewController {
    
    //This is for the cells
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return EventsManager.events.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // formats and deformats the given date
        let cellDateFormat = DateFormatter()
        cellDateFormat.dateFormat = "dd/MM/yyyy-HH:mm"
        let getDate = cellDateFormat.date(from: EventsManager.events[indexPath.row].dateTime)
        let cellCalender = Calendar(identifier: .gregorian)
        let weekDay = cellCalender.component(.weekday, from: getDate!)
        
        //output date format
        cellDateFormat.dateFormat = "dd MMM yyyy"
        let newOutput = cellDateFormat.string(from: getDate!)
        //let timeOutput = "\(Calendar.current.component(.hour, from: getDate())):\(Calender.current.component(.minute, from: getDate()))"
        cellDateFormat.dateFormat = "HH:mm a"
        let timeOutput = cellDateFormat.string(from: getDate!)
        
        //This creates the cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EventsViewCell", for: indexPath) as! EventCell
        
        //cell formatting
        cell.backgroundColor = .white
        cell.layer.masksToBounds = true
        cell.layer.cornerRadius = 10
        
        //cell data
        cell.dayOTWLabel.text = gregorianCalendar[weekDay - 1]
        cell.DateLabel.text = newOutput
        cell.ddescriptionLabel.text = "\(EventsManager.events[indexPath.row].description) with  \(EventsManager.events[indexPath.row].person.name)"
        cell.timeLabel.text = timeOutput
        cell.locationLabel.text = EventsManager.events[indexPath.row].location
        cell.eventObject = EventsManager.events[indexPath.row]
        cell.eventDelegate = self
        cell.layoutIfNeeded()
        return cell
    }
}
