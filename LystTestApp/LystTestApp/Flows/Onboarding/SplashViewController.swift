//
//  SplashViewController.swift
//  Lyst Test App
//
//  Created by Mohsin Hussain on 07/08/2021.
//

import UIKit
import LystAssets

class SplashViewController: UIViewController {

    @IBOutlet weak var splashLogoImage: UIImageView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        performInitialSetup()
        addDelayAndMoveToHome()
    }
    
    private func performInitialSetup() {
        splashLogoImage?.image = Asset.splashLogo.image
    }
    
    private func addDelayAndMoveToHome() {
       DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(2)) {
        AppNavigator.displayHomeScreen()
       }
    }
}
