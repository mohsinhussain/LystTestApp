//
//  AppNavigator.swift
//  Lyst Test App
//
//  Created by Mohsin Hussain on 07/08/2021.
//

import UIKit
import Foundation

/** Used for loading the app structure at turning points like app launch, login or logout */
final class AppNavigator {
    /** Replaces root view controller with animation */

    static var navigationController: NavigationController?

    static func setRootViewController(_ rootController: UIViewController, animated: Bool) {
        let scene = UIApplication.shared.connectedScenes.first
        if let sceneDelegate: SceneDelegate = (scene?.delegate as? SceneDelegate), let window = sceneDelegate.window {
            navigationController = NavigationController(rootViewController: rootController)

            if rootController is DogsListViewController {
                navigationController?.homeScreenInitialSetup()
            }

            if !animated || window.rootViewController == nil {
                window.rootViewController = navigationController
                window.makeKeyAndVisible()
            } else {
                UIView.transition(with: window, duration: 0.25,
                                  options: UIView.AnimationOptions.transitionFlipFromRight, animations: {
                                    window.rootViewController = navigationController
                                    window.makeKeyAndVisible()
                                  }, completion: nil)
            }
        }
    }
    
    static func displayHomeScreen() {
        DispatchQueue.main.async {
            let dogsListViewController = DogsListViewController(nibName: String(describing: DogsListViewController.self), bundle: nil)
    //        let dogsListViewController = DogsListViewController()
            setRootViewController(dogsListViewController, animated: true)
        }
        
    }
    
}
