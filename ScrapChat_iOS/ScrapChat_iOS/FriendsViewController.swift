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
    
    private var collectionData = ["Neveah Wilkins", "Rylie Knox", "Yuliana Jennings", "Ezekiel Fields", "Edith Meyer", "Micaela Curry", " Marshall Hamilton", " Nicolas Phillips", "Aleena Butler", "Raiden Ross", "Antony Downs", "Jade Caldwell"]

    let padding: CGFloat = 300
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        friendCollection.delegate = self
        friendCollection.dataSource = self
        
        let width = view.frame.width * 0.75
        let height = view.frame.height / 6
        let layout = friendCollection.collectionViewLayout as! UICollectionViewFlowLayout
        
        print(width)
        print(friendCollection.frame.width)
        layout.itemSize = CGSize(width: width, height: height)
        layout.minimumLineSpacing = 20
    }
    
}

extension FriendsViewController {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionData.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! FriendCell
        cell.backgroundColor = .white
        cell.layer.masksToBounds = true
        cell.layer.cornerRadius = 10
        cell.cellLabel.text = (collectionData[indexPath.row])
        cell.layoutIfNeeded()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }
    
    
}
