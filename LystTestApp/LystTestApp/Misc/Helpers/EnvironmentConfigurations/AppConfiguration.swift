//
//  AppConfiguration.swift
//  LystTestApp
//
//  Created by Mohsin Hussain on 08/08/2021.
//

import Foundation
import LystNetworkManager
import LystModels

/** Helper class for getting runtime configuration from plist files */

final class AppConfiguration {
    
    enum Configuration: String {
        case debug = "Debug"
        case staging = "Staging"
        case release = "Release"
    }
    
    fileprivate enum EnvironmentProperty: String {
        case dogURL
        case apiKey
        
        var stringValue: String {
            let appConfig = try? AppConfiguration.shared.setting(self)
            return appConfig ?? ""
        }
        
        var urlValue: URL? {
            let appConfig = try? URL(string: AppConfiguration.shared.setting(self))
            return appConfig

        }
    }
    
    fileprivate var environmentsDict: NSDictionary!
    fileprivate let configurationKey = "Configuration"
    fileprivate let environmentPlistName = "EnvironmentVariables"
    fileprivate var activeConfiguration: Configuration?
    fileprivate var activeEnviromentDictionary: NSDictionary!
    
    static let shared = AppConfiguration()

   
    func initializeConfig() {
        let bundle = Bundle(for: AppConfiguration.self)
        let configurationName = (bundle.infoDictionary?[configurationKey] as? String)!
        self.activeConfiguration = Configuration(rawValue: configurationName)

        // load our configuration plist
        let environmentsPath = bundle.path(forResource: environmentPlistName, ofType: "plist")!
        environmentsDict = NSDictionary(contentsOfFile: environmentsPath)


        if let envDict = environmentsDict,
           let region = Region(rawValue: UserDefaultsEnum.selectedRegion)?.rawValue,
           let regionDict = envDict[region] as? NSDictionary,
           let activeDictionary = (regionDict[activeConfiguration?.rawValue] as? NSDictionary) {
            self.activeEnviromentDictionary = activeDictionary
            print("active dict is \(activeEnviromentDictionary)")
        }

    }
    fileprivate init() {
       initializeConfig()
    }
    
    fileprivate func setting(_ property: EnvironmentProperty) throws -> String {
        if let value = self.activeEnviromentDictionary[property.rawValue] as? String {
            return value
        }
        throw NSError(domain: "No <\(property.rawValue)> setting has been found", code: 100012, userInfo: nil)
    }
    
    func isRunningInRelease() -> Bool {
        guard let activeConfig = self.activeConfiguration else {
            return false
        }
        return activeConfig == Configuration.release
    }
    
    func getActiveConfiguration() -> Configuration {
        return activeConfiguration!
    }

    func getBaseURL() -> String {
        return EnvironmentProperty.dogURL.stringValue + "/"
    }

    func getApiKey() -> String {
          return EnvironmentProperty.apiKey.stringValue
    }

}
