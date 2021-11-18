//
//  CommunityViewController.swift
//  ScrapChat_iOS
//
//  Created by Jaiden Chicote on 14/9/19.
//  Copyright © 2019 Dream Team. All rights reserved.
//

import UIKit

class FriendsViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    @IBOutlet weak var friendCollection: UICollectionView!
    @IBOutlet var minglebackImage: UIImageView!
    //@IBOutlet var mingleIcon: UIImageView!
    
    //Event Outlets
    @IBOutlet weak var descriptionOut: UITextField!
    @IBOutlet weak var timePicker: UIDatePicker!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var eventView: UIView!
    @IBOutlet weak var darkMode: UIView!
    
    //event constraint
    @IBOutlet weak var eventCenterY: NSLayoutConstraint!
    
    //temp test data
    private var collectionData = ["Neveah Wilkins", "Rylie Knox", "Yuliana Jennings", "Ezekiel Fields", "Edith Meyer", "Micaela Curry", " Marshall Hamilton", " Nicolas Phillips", "Aleena Butler", "Raiden Ross", "Antony Downs", "Jade Caldwell"]

    //padding for cells to prevent 'breaking' constraints
    let padding: CGFloat = 300
    var friendList = FriendManager()
    var fetchedPerson: Person?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        darkMode.alpha = 0
        eventView.layer.cornerRadius = 20
        eventView.layer.masksToBounds = true
        eventCenterY.constant = 1500
        minglebackImage.tintColor = #colorLiteral(red: 0.8078431373, green: 0.7921568627, blue: 0.7921568627, alpha: 1)
        
        friendCollection.delegate = self
        friendCollection.dataSource = self
        
        //setup general cell layout
        let width = view.frame.width * 0.75
        let height = view.frame.height / 6
        let layout = friendCollection.collectionViewLayout as! UICollectionViewFlowLayout
        
        print(width)
        print(friendCollection.frame.width)
        layout.itemSize = CGSize(width: width, height: height)
        layout.minimumLineSpacing = 20
    }
    
    @IBAction func onMingle(_ sender: Any){
        UIView.animate(withDuration: 0.1) {
            self.minglebackImage.tintColor = #colorLiteral(red: 1, green: 0.7993489356, blue: 0, alpha: 1)
        }
        let storyboard = UIStoryboard(name: "VideoChatScreen", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: Constants.Storyboard.ChatVC)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func backPressed(_ sender: UIButton) {
       let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let HomeVC = storyboard.instantiateViewController(withIdentifier: Constants.Storyboard.HomeVC)
       UIApplication.shared.keyWindow?.rootViewController = HomeVC
    }
    
    @IBAction func accountsPressed(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Accounts", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: Constants.Storyboard.AccountsVC)
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    @IBAction func eventsPressed(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Events Storyboard", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: Constants.Storyboard.EventsVC)
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    @IBAction func scrapbookPressed(_ sender: Any) {
        let storyboard = UIStoryboard(name: "ScrapbookStoryboard", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: Constants.Storyboard.ScrapBookVC)
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    
    @IBAction func onCancel(_ sender: Any) {
        eventCenterY.constant = 1500
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
            self.darkMode.alpha = 0
        }
    }
    
    @IBAction func onComplete(_ sender: Any) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy-HH:mm"
        
        eventCenterY.constant = 1500
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
            self.darkMode.alpha = 0
        }
        
        let stringDate = dateFormatter.string(from: datePicker.date)
        EventsManager.events.append(EventsObject(dayOTW: "Default", dateTime: stringDate, amPM: "am", description: descriptionOut.text!, location: "Unknown", person: fetchedPerson!))
        
        let iteratedDateFormat = DateFormatter()
        iteratedDateFormat.dateFormat = "dd/MM/yyy-HH:mm"
        
        let sortedEvents = EventsManager.events.sorted { iteratedDateFormat.date(from: $0.dateTime)! < iteratedDateFormat.date(from: $1.dateTime)!
        }
        EventsManager.events = sortedEvents
    }
    
    @IBAction func onSettings(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: Constants.Storyboard.SettingVC)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension FriendsViewController : CellDelegate {
    func didTapCall(person: Person) {
        let storyboard = UIStoryboard(name: "VideoChatScreen", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: Constants.Storyboard.MainCallScreen) as! VideoChatController
        vc.callRecipient = person
        print(person.name)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func didTapEvent(person: Person) {
        fetchedPerson = person
        
        eventCenterY.constant = 0
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
            self.darkMode.alpha = 0.8
        }
    }
}

//This extension supplements the controller with flow layout and delegate classes for collection view
extension FriendsViewController {
    
    //defines the length of cell items (before being loaded into screen)
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return FriendManager.friendArray.count
    }
    
    
    //creates reusable programatic collection cells
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! FriendCell
        cell.cellDelegate = self
        cell.individual = FriendManager.friendArray[indexPath.row]
        cell.backgroundColor = .white
        cell.layer.masksToBounds = true
        cell.layer.cornerRadius = 10
        cell.cellLabel.text = (FriendManager.friendArray[indexPath.row].name)
        cell.layoutIfNeeded()
        return cell
    }
    
    //set the collection view edge insets
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }
}
