//
//  AppRouter.swift
//  Lyst Test App
//
//  Created by Mohsin Hussain on 07/08/2021.
//

import UIKit

class AppRouter {

    private let window: UIWindow?

    init(window: UIWindow?) {
        self.window = window
    }

    // MARK: - Public -

    func startApplication() {
        let splashViewController = SplashViewController(nibName: String(describing: SplashViewController.self), bundle: nil)
        window?.rootViewController = splashViewController
        window?.makeKeyAndVisible()
    }

}
