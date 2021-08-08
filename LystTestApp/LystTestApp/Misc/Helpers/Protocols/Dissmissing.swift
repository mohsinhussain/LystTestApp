//
//  Dissmissing.swift
//  LystTestApp
//
//  Created by Mohsin Hussain on 08/08/2021.
//

import Foundation
import UIKit

public protocol Dismissing: UIViewController {

    func dismiss(animated: Bool)
    func dismissToRoot()
}

extension Dismissing {

    public func dismiss(animated: Bool = true) {
        if self.navigationController != nil {
            self.navigationController?.popViewController(animated: animated)
        } else {
            self.dismiss(animated: animated)
        }
    }

    public func dismissToRoot() {
        self.navigationController?.popToRootViewController(animated: true)
    }
}
