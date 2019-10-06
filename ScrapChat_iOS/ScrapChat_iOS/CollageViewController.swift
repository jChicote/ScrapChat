//
//  CollageViewController.swift
//  ScrapChat_iOS
//
//  Created by Jaiden Chicote on 4/10/19.
//  Copyright © 2019 Dream Team. All rights reserved.
//

import UIKit

protocol CollageToChat {
    func clearCollage(makeClear: Bool)
}

class CollageViewController: UIViewController, UIDragInteractionDelegate, UIDropInteractionDelegate{
    
    @IBOutlet weak var testImage: UIImageView!
    
    var viewActive = false
    var isAdded = false
    var clearBoard = false
    var videoChat: VideoChatController?
    var timer: Timer!
    var currentTag: Int!
    
    var ccDelegate: CollageToChat?
    
    var default_Images = [UIImage(named: "stock-image-1")!, UIImage(named: "stock-image-2")!, UIImage(named: "stock-image-3")!, UIImage(named: "stock-image-4")!, UIImage(named: "stock-image-5")!, UIImage(named: "stock-image-6")!, UIImage(named: "stock-image-7")!, UIImage(named: "stock-image-8")!, UIImage(named: "stock-image-9")!, UIImage(named: "stock-image-10")!, UIImage(named: "stock-image-11")!, UIImage(named: "stock-image-12")!]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addInteraction(UIDragInteraction(delegate: self))
        view.addInteraction(UIDropInteraction(delegate: self))

        // Do any additional setup after loading the view.
        timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(renderNewImage), userInfo: nil, repeats: true)
    }
    
    @objc func renderNewImage() {
        
        if isAdded == false {
            currentTag = Int.random(in: 0 ..< 999)
            let numVal = Int.random(in: 0 ..< default_Images.count)
            let newImage = UIImageView(image:default_Images[numVal])
            newImage.isUserInteractionEnabled = true
            newImage.frame = CGRect(x: 40, y: 40, width: view.frame.width * 0.2, height: (view.frame.width * 0.2) * (default_Images[numVal].size.height/default_Images[numVal].size.width))
            newImage.tag = currentTag
            self.view.addSubview(newImage)
            print("Added new image")
            isAdded = true
        } else {
            if let subview = self.view.viewWithTag(currentTag) {
                subview.removeFromSuperview()
            }
            let numVal = Int.random(in: 0 ..< default_Images.count)
            let newImage = UIImageView(image:default_Images[numVal])
            newImage.isUserInteractionEnabled = true
            newImage.tag = currentTag
            newImage.frame = CGRect(x: 40, y: 40, width: view.frame.width * 0.3, height: (view.frame.width * 0.3) * (default_Images[numVal].size.height/default_Images[numVal].size.width))
            self.view.addSubview(newImage)
            print("reloaded new image")
        }
    }
    
    func dragInteraction(_ interaction: UIDragInteraction, itemsForBeginning session: UIDragSession) -> [UIDragItem] {
        
        let touchedPoint = session.location(in: self.view)
        print(touchedPoint)
        if let touchedImageView = self.view.hitTest(touchedPoint, with: nil) as? UIImageView {
            let touchedImage = touchedImageView.image
            isAdded = false
            let itemProvider = NSItemProvider(object: touchedImage!)
            let dragItem = UIDragItem(itemProvider: itemProvider)
            
            dragItem.localObject = touchedImageView
            return [dragItem]
        }
        
        return []
    }
    
    func dropInteraction(_ interaction: UIDropInteraction, canHandle session: UIDropSession) -> Bool {
        return session.canLoadObjects(ofClass: UIImage.self)
    }
    
    func dropInteraction(_ interaction: UIDropInteraction, sessionDidUpdate session: UIDropSession) -> UIDropProposal {
        return UIDropProposal(operation: .copy)
    }
    
    func dropInteraction(_ interaction: UIDropInteraction, performDrop session: UIDropSession) {
        for dragItem in session.items {
            dragItem.itemProvider.loadObject(ofClass: UIImage.self, completionHandler: {
                (obj, err) in
                
                if let err = err {
                    print("dragged items failed to load", err)
                    return
                }
                
                guard let draggedImage = obj as? UIImage else {return}
 
                DispatchQueue.main.async {
                    let imageView = UIImageView(image:draggedImage)
                    imageView.isUserInteractionEnabled = true
                    imageView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width * 0.2, height: (self.view.frame.width * 0.2) * (draggedImage.size.height/draggedImage.size.width))
                    self.view.addSubview(imageView)
                    print(imageView.frame)
                    let centerPoint = session.location(in: self.view)
                    imageView.center = centerPoint
                }
            })
        }
    }
    
    func dragInteraction(_ interaction: UIDragInteraction, previewForLifting item: UIDragItem, session: UIDragSession) -> UITargetedDragPreview? {
        return UITargetedDragPreview(view: item.localObject as! UIView)
    }
    
    func dragInteraction(_ interaction: UIDragInteraction, willAnimateLiftWith animator: UIDragAnimating, session: UIDragSession) {
        session.items.forEach { (dragItem) in
            if let touchedImageView = dragItem.localObject as? UIView {
                touchedImageView.removeFromSuperview()
            }
        }
    }
    
    func dragInteraction(_ interaction: UIDragInteraction, item: UIDragItem, willAnimateCancelWith animator: UIDragAnimating) {
        self.view.addSubview(item.localObject as! UIView)
    }
    
    func clearTheBoard() {
        for subview in view.subviews{
            subview.removeFromSuperview()
        }
    }
    
    func checkCollage() -> Int {
        var count = 0
        for _ in view.subviews{
            count += 1
        }
        print(count)
        return count
    }
}
