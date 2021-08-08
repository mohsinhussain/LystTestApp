//
//  ReusableCell.swift
//  Lyst Test App
//
//  Created by Mohsin Hussain on 07/08/2021.
//

import Foundation

public protocol ReusableCell {
    
    static var reuseIdentifier: String { get }
}

extension ReusableCell {
    
    static public var reuseIdentifier: String { return String(describing: self) }
}
