//
//  AbstractViewModel.swift
//  Lyst Test App
//
//  Created by Mohsin Hussain on 07/08/2021.
//

import Foundation

protocol ViewModelUIDelegate: AnyObject {
    func updateUI(data: Any?, status: StatusEnum?, actionSource: String?)
}

extension ViewModelUIDelegate {
    func updateUI(data: Any? = nil, status: StatusEnum? = nil, actionSource: String? = nil) {
        updateUI(data: data, status: status, actionSource: actionSource)
    }
}

class AbstractViewModel: NSObject {
    weak var delegate: ViewModelUIDelegate?
}
