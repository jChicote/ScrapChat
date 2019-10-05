//
//  ActivityIndicatorViewController.swift
//  ScrapChat_iOS
//
//  Created by Richard Christiansen on 5/10/19.
//  Copyright © 2019 Dream Team. All rights reserved.
//

import UIKit

class ActivityIndicator: UIViewController {
    let activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    func startActivity() {
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = .gray
        view.addSubview(activityIndicator)
        
        activityIndicator.startAnimating()
        UIApplication.shared.beginIgnoringInteractionEvents()
    }
    
    func stopActivity() {
        activityIndicator.stopAnimating()
        UIApplication.shared.endIgnoringInteractionEvents()
    }
}
