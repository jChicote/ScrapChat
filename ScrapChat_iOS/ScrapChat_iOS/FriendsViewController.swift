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
    
    
    //temp test data
    private var collectionData = ["Neveah Wilkins", "Rylie Knox", "Yuliana Jennings", "Ezekiel Fields", "Edith Meyer", "Micaela Curry", " Marshall Hamilton", " Nicolas Phillips", "Aleena Butler", "Raiden Ross", "Antony Downs", "Jade Caldwell"]

    //padding for cells to prevent 'breaking' constraints
    let padding: CGFloat = 300
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    
}

//This extension supplements the controller with flow layout and delegate classes for collection view
extension FriendsViewController {
    
    //defines the length of cell items (before being loaded into screen)
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionData.count
    }
    
    
    //creates reusable programatic collection cells
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! FriendCell
        cell.backgroundColor = .white
        cell.layer.masksToBounds = true
        cell.layer.cornerRadius = 10
        cell.cellLabel.text = (collectionData[indexPath.row])
        cell.layoutIfNeeded()
        return cell
    }
    
    //set the collection view edge insets
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }
}
