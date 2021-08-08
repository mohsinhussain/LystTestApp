//
//  NavigationController.swift
//  Lyst Test App
//
//  Created by Mohsin Hussain on 07/08/2021.
//

import Foundation
import UIKit
import LystExtensions

class NavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        performInitialSetup()
    }
    
    // MARK: - Public -

    func performInitialSetup() {
        navigationBar.barTintColor = .white
        navigationBar.isTranslucent = false
        navigationBar.backgroundColor = .white
        navigationBar.tintColor = .black
        navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black,
                                             .font: UIFont.title]
    }

    func homeScreenInitialSetup() {
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        navigationBar.isTranslucent = true
        navigationBar.backgroundColor = .clear
        navigationBar.tintColor = .black
    }
        
}

// MARK: - Constants -

private extension UIFont {
    
    static let title: UIFont =
        UIFont.font(typeFace: .semiBold, size: .titleFontSize)
}

private extension CGFloat {
    
    static let titleFontSize: CGFloat = 18
}
