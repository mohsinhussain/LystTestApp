//
//  AlertDisplaying.swift
//  Lyst Test App
//
//  Created by Mohsin Hussain on 07/08/2021.
//

import Foundation
import UIKit

public protocol AlertDisplaying {
    func displayNoInternetConnectionError() -> UIAlertController
    func display(errorTitle: String, subtitle: String?) -> UIAlertController
}

extension AlertDisplaying {
    
    public func display(errorTitle: String, subtitle: String? = "") -> UIAlertController {
        let alert = UIAlertController(title: errorTitle, message: subtitle, preferredStyle: .alert)
        let closeAction = UIAlertAction(title: "OKAY", style: .cancel, handler: nil)
        alert.addAction(closeAction)
        return alert
    }

    public func displayNoInternetConnectionError() -> UIAlertController {
        let alert = UIAlertController(title: "No Connection", message: "Please check if you are connected with internet", preferredStyle: .alert)
        let closeAction = UIAlertAction(title: "OKAY", style: .cancel, handler: nil)
        alert.addAction(closeAction)
        return alert
    }

    
}
