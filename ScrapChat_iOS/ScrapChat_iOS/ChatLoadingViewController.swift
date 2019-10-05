//
//  ChatLoadingViewController.swift
//  ScrapChat_iOS
//
//  Created by Jaiden Chicote on 3/10/19.
//  Copyright © 2019 Dream Team. All rights reserved.
//

import UIKit

class ChatLoadingViewController: UIViewController {

    @IBOutlet weak var loadingAnimView: UIView!
    @IBOutlet weak var circle1: UIView!
    @IBOutlet weak var circle2: UIView!
    @IBOutlet weak var circle3: UIView!
    
    //Display Pop Window
    @IBOutlet weak var popWindow: UIView!
    @IBOutlet weak var popWindowY: NSLayoutConstraint!
    
    //Window Outlets
    @IBOutlet weak var matchedName: UILabel!
    
    
    var displayLink: CADisplayLink!
    var timer: Timer!
    let color: UIColor = #colorLiteral(red: 1, green: 0.799602002, blue: 0.005400067895, alpha: 1)
    var chosenRecipient: Person?
    var listOfPeople = PeopleManageer()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        circle1.layer.cornerRadius = 40
        circle2.layer.cornerRadius = 40
        circle3.layer.cornerRadius = 40
        popWindow.layer.cornerRadius = 20
        
        displayLink = CADisplayLink(target: self, selector: #selector(handleLoadAnimations))
        displayLink.add(to: RunLoop.main, forMode: .default)
        timer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(stopAnimation), userInfo: nil, repeats: false)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? VideoChatController {
            controller.callRecipient = self.chosenRecipient
        }
    }
    
    //animation section
    var constant1: CGFloat = 2.0
    var constant2: CGFloat = 2.0
    var constant3: CGFloat = 2.0
    
    var value1: CGFloat = 60.0
    var value2: CGFloat = 30.0
    var value3: CGFloat = 10.0
    
    @objc func handleLoadAnimations() {
        value1 += constant1
        value2 += constant2
        value3 += constant3
        
        circle1.backgroundColor = color.withAlphaComponent(value1/100)
        circle2.backgroundColor = color.withAlphaComponent(value2/100)
        circle3.backgroundColor = color.withAlphaComponent(value3/100)
        
        if (value1 > 100 || value1 < 0) {
            constant1.negate()
        } else if (value2 > 100 || value2 < 0) {
            constant2.negate()
        } else if (value3 > 100 || value3 < 0) {
            constant3.negate()
        }
    }
    
    @objc func stopAnimation() {
        chooseCaller()
        matchedName.text = chosenRecipient?.name
        popWindowY.constant = 0.0
        displayLink?.invalidate()
        displayLink = nil
        UIView.animate(withDuration: 0.5) {
            self.loadingAnimView.alpha = 0;
            self.view.layoutIfNeeded()
        }
        
    }
    
    @IBAction func declineSuggestion(_ sender: Any) {
        popWindowY.constant = 900.0
        UIView.animate(withDuration: 0.2) {
            self.view.layoutIfNeeded()
            self.loadingAnimView.alpha = 1;
        }
        displayLink = CADisplayLink(target: self, selector: #selector(handleLoadAnimations))
        displayLink.add(to: RunLoop.main, forMode: .default)
        timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(stopAnimation), userInfo: nil, repeats: false)
    }
    
    @IBAction func backButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    func chooseCaller() {
        let number = Int.random(in: 0 ..< listOfPeople.peopleArray.count)
        chosenRecipient = listOfPeople.peopleArray[number]
    }
    
}
