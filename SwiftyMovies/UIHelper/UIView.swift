//
//  UIView.swift
//  MovieList
//
//  Created by apple on 12/02/24.
//

import Foundation
import UIKit

extension UIView {

    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
}
