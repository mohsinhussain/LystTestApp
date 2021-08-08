//
//  UserDefaultsInfo.swift
//  LystTestApp
//
//  Created by Mohsin Hussain on 08/08/2021.
//

import Foundation
import LystModels

internal struct UserDefaultInfo<Value> {
    var key: String
    var defaultValue: Value
}

internal extension UserDefaultInfo {

    func get() -> Value {
        guard let valueUntyped = UserDefaults.standard.object(forKey: self.key), let value = valueUntyped as? Value else {
            return self.defaultValue
        }

        return value
    }

    func set(_ value: Value) {
        UserDefaults.standard.set(value, forKey: self.key)
    }
    
    func getObject<T: Decodable>() -> T? {
        if let data = UserDefaults.standard.data(forKey: self.key) {
            return try? JSONDecoder().decode(T.self, from: data)
        } else {
            return nil
        }
    }
    
    func setObject<T: Encodable>(encodable: T) {
        if let data = try? JSONEncoder().encode(encodable) {
            UserDefaults.standard.setValue(data, forKey: self.key)
        }
    }
    
}

enum UserDefaultsEnum {
   
    // MARK: - App UserDefaults -
    
    static var selectedRegion: String {
        get { return selectedRegionInfo.get() }
        set { selectedRegionInfo.set(newValue) }
    }

    private static var selectedRegionInfo = UserDefaultInfo(key: "selectedRegionInfo", defaultValue: "UK")
}

// Save and load a custom object to UserDefaults.
// Note that the Model must conform to Codable. See Language model

extension UserDefaults {

    func set<T: Encodable>(encodable: T, forKey key: String) {
        if let data = try? JSONEncoder().encode(encodable) {
            set(data, forKey: key)
        }
    }

    func value<T: Decodable>(_ type: T.Type, forKey key: String) -> T? {
        if let data = object(forKey: key) as? Data,
            let value = try? JSONDecoder().decode(type, from: data) {
            return value
        }
        return nil
    }
    
}
