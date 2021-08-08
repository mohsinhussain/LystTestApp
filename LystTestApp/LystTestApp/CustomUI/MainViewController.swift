//
//  MainViewController.swift
//  Lyst Test App
//
//  Created by Mohsin Hussain on 07/08/2021.
//

import Foundation
import UIKit

class MainViewController: UIViewController, Dismissing, AlertDisplaying, ActivityDisplaying {

    var displayInternetConnectionError: Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpNotificationObservers()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if displayInternetConnectionError {
            checkInternetConnection()
        }
    }
    
    @objc func reachabilityChanged(_ note: Notification) {
        autoRefresh()
    }
    
    @objc func appDidBecomeActive(_ notification: Notification) {
        autoRefresh()
    }
    
    func autoRefresh() { // Override this if app enters foreground or if there is change in internet connection
        
        /*
         * Always check if the current visible ViewController is your ClassName (ViewController)
         * to avoid calling all functions under autoRefresh() in other classes
         * because autoRefresh is triggered for all views in a tab bar.
         * This should be applied to all ViewControllers inheriting MainViewController.
         *
         */
        
        debugPrint("going autoRefresh")
        // reconnecting iot hub if its disconnected due to internet
        if !InternetObserver.shared.isOnline {
            (UIApplication.shared.keyWindow!.rootViewController as? UINavigationController)?.present(displayNoInternetConnectionError(), animated: true, completion: nil)
        }
    }
    
    func checkInternetConnection() {
        if !InternetObserver.shared.isOnline {
            (UIApplication.shared.keyWindow!.rootViewController as? UINavigationController)?.present(displayNoInternetConnectionError(), animated: true, completion: nil)
        }
    }
    
    func setUpNotificationObservers() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.reachabilityChanged(_:)),
                                               name: NSNotification.Name(rawValue: NotificationNames.rechabilityStatusChanged),
                                               object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.appDidBecomeActive(_:)),
                                               name: NSNotification.Name(rawValue: NotificationNames.appDidBecomeActive),
                                               object: nil)
    }
}
