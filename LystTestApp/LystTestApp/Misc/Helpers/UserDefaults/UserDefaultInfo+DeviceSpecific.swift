//
//  UserDefaultInfo+DeviceSpecific.swift
//  LystTestApp
//
//  Created by Mohsin Hussain on 08/08/2021.
//

import Foundation

let deviceSpecificUserDefaultsKeys = ["xAPIKey"]

extension UserDefaultsEnum {
    
    static var xAPIKey: String {
        get { return xAPIKeyInfo.get() }
        set { xAPIKeyInfo.set(newValue) }
    }
    
    private static var xAPIKeyInfo = UserDefaultInfo(key: "xAPIKeyInfo", defaultValue: "")


}
