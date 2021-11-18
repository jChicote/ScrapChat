//
//  ScrapBookViewController.swift
//  ScrapChat_iOS
//
//  Created by Jaiden Chicote on 14/9/19.
//  Copyright © 2019 Dream Team. All rights reserved.
//

import UIKit

class ScrapBookViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var scrapCollection: UICollectionView!
    @IBOutlet weak var darkMask: UIView!
    @IBOutlet weak var viewPreview: UIView!
    @IBOutlet weak var imageView: UIImageView!
    
    var imagePreview: UIImage?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        viewPreview.layer.cornerRadius = 20
        
        scrapCollection.delegate = self
        scrapCollection.dataSource = self
        
        //setup general cell layout
        let width = view.frame.width * 0.25
        let height = view.frame.height * 0.545
        let layout = scrapCollection.collectionViewLayout as! UICollectionViewFlowLayout
        
        //print(friendCollection.frame.width)
        layout.itemSize = CGSize(width: width, height: height)
        layout.minimumInteritemSpacing = 20
    }
    
    func fadeInPreview() {
        imageView.image = imagePreview
        self.imageView.contentMode = .scaleAspectFill
        UIView.animate(withDuration: 0.3) {
            self.darkMask.alpha = 0.8
            self.viewPreview.alpha = 1
        }
    }
    
    @IBAction func closePreview(_ sender: Any) {
        UIView.animate(withDuration: 0.3) {
            self.darkMask.alpha = 0
            self.viewPreview.alpha = 0
        }
    }
    
    @IBAction func onSetting(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: Constants.Storyboard.SettingVC)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func eventTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Events Storyboard", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: Constants.Storyboard.EventsVC)
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    @IBAction func accountTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Accounts", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: Constants.Storyboard.AccountsVC)
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    @IBAction func friendsTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "FriendsStoryboard", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: Constants.Storyboard.FriendsVC)
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    @IBAction func mingleTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "VideoChatScreen", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: Constants.Storyboard.ChatVC)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension ScrapBookViewController: CollageCellDelegate {
    func didTapCell(pImage: UIImage) {
        imagePreview = pImage
        fadeInPreview()
    }
}

extension ScrapBookViewController {
    //defines the length of cell items (before being loaded into screen)
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return LocalScrapManager.scraps.count
    }
    
    
    //creates reusable programatic collection cells
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ScrapViewCell", for: indexPath) as! CollageCell
        cell.date.text = formatter.string(from: LocalScrapManager.scraps[indexPath.row].date)
        cell.name.text = LocalScrapManager.scraps[indexPath.row].partner.name
        cell.thumbnail.image = LocalScrapManager.scraps[indexPath.row].collage
        cell.thumbnail.contentMode = .scaleAspectFill
        cell.layer.cornerRadius = 20
        cell.layer.masksToBounds = true
        cell.delegateCell = self

        return cell
    }
    
    //set the collection view edge insets
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }
}
