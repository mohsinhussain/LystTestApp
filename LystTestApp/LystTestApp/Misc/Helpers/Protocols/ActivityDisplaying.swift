//
//  ActivityDisplaying.swift
//  LystTestApp
//
//  Created by Mohsin Hussain on 08/08/2021.
//

import Foundation
import NVActivityIndicatorViewExtended
import UIKit

public protocol ActivityDisplaying {
    
    func showActivity()
    func hideActivity()
}

extension ActivityDisplaying {
    
    public func showActivity() {
        if !NVActivityIndicatorPresenter.sharedInstance.isAnimating {
            let activityData = ActivityData(size: CGSize(width: 60.0, height: 60.0),
                                            message: "", messageFont: nil, messageSpacing: nil, type: .circleStrokeSpin,
                                            color: .darkGray, padding: nil, displayTimeThreshold: nil,
                                            minimumDisplayTime: nil, backgroundColor: UIColor.white.withAlphaComponent(0.3), textColor: nil)

            NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)
        }
    }
    
    public func hideActivity() {
        NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
    }
    
}
