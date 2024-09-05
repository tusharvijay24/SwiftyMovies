//
//  Alerts.swift
//  SwiftyMovies
//
//  Created by Tushar on 05/09/24.
//

import Foundation
import Foundation
import UIKit

func showAlertWithOutCancel(on viewController: UIViewController, title: String, message: String, buttonTitle: String, completion: (() -> Void)?) {
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    
    let action = UIAlertAction(title: buttonTitle, style: .default) { (_) in
        completion?()
    }
    alertController.addAction(action)
    viewController.present(alertController, animated: true, completion: nil)
}
