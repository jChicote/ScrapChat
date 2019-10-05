//
//  AlertController.swift
//  ScrapChat_iOS
//
//  Created by Richard Christiansen on 5/10/19.
//  Copyright © 2019 Dream Team. All rights reserved.
//

import UIKit

extension UIViewController {
    func showAlert(_ message: String, withHeader: String) {
        let alertController = UIAlertController(title: withHeader, message:
            message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
        self.present(alertController, animated: true, completion: nil)
    }
}
