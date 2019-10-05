//
//  CollageViewController.swift
//  ScrapChat_iOS
//
//  Created by Jaiden Chicote on 4/10/19.
//  Copyright © 2019 Dream Team. All rights reserved.
//

import UIKit

class CollageViewController: UIViewController, UIDragInteractionDelegate, UIDropInteractionDelegate{
    
    @IBOutlet weak var testImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addInteraction(UIDragInteraction(delegate: self))
        view.addInteraction(UIDropInteraction(delegate: self))

        // Do any additional setup after loading the view.
        testImage.isUserInteractionEnabled = true
    }
    
    func dragInteraction(_ interaction: UIDragInteraction, itemsForBeginning session: UIDragSession) -> [UIDragItem] {
        
        let touchedPoint = session.location(in: self.view)
        print(touchedPoint)
        if let touchedImageView = self.view.hitTest(touchedPoint, with: nil) as? UIImageView {
            let touchedImage = touchedImageView.image
            
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
                    self.view.addSubview(imageView)
                    imageView.frame = CGRect(x: 0, y: 0, width: draggedImage.size.width, height: draggedImage.size.height)
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
    
    

}
