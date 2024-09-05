//
//  VcSplash.swift
//  SwiftyMovies
//
//  Created by Tushar on 05/09/24.
//

import UIKit

class VcSplash: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.redirectFromSplash()
        }
    }

    @objc func redirectFromSplash() {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        if let rootController = mainStoryboard.instantiateInitialViewController() {
            if let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) {
                window.rootViewController = rootController
                window.makeKeyAndVisible()
            }
        }
    }
}
