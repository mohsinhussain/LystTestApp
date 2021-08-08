//
//  ServicesFactory.swift
//  Lyst Test App
//
//  Created by Mohsin Hussain on 07/08/2021.
//

import Foundation
import LystDatabaseManager
import LystNetworkManager

class ServicesFactory {
    

    // MARK: - Singleton -
    
    static let shared: ServicesFactory = ServicesFactory()
    
    private init() {}
    
    // MARK: - Public -
    

    
    func makeKeychainService() -> KeychainProtocol {
        return KeychainService()
    }
//
//
//
//    func makeConfigurationService() -> ConfigurationServiceProtocol {
//        return ConfigurationService(networkingManager: makeAuthorizedNetworkService(), databaseService: makeDatabaseService())
//    }
//
//    func makeLocationService() -> LocationServiceProtocol {
//        return LocationService(networkingManager: makeAuthorizedNetworkService())
//    }
//
//    func makePushNotificationService() -> PushNotificationServiceProtocol {
//        return PushNotificationService(networkingManager: makeAuthorizedNetworkService(), databaseService: makeDatabaseService())
//    }
//
//    func makeLanguageService() -> LanguageServiceProtocol {
//        return LanguageService(databaseService: makeDatabaseService())
//    }
//
//    func makeCountriesService() -> CountriesServiceProtocol {
//        return CountriesService(databaseService: AhoyDatabaseService())
//    }

    func makeBreedService() -> BreedServiceProtocol {
        return BreedService(networkingManager: makeAuthorizedNetworkService(), databaseService: makeDatabaseService())
    }

//    func makeDeliveryService() -> DeliveryServiceProtocol {
//        return DeliveryService(networkingManager: makeAuthorizedNetworkService(), databaseService: makeDatabaseService())
//    }
//    
//    func makeDeliveryMerchantService() -> DeliveryMerchantServiceProtocol {
//        return DeliveryMerchantService(networkingManager: makeAuthorizedNetworkService(), databaseService: makeDatabaseService())
//    }
//    
//    func makeTransactionService() -> TransactionServiceProtocol {
//        return TransactionService(networkingManager: makeAuthorizedNetworkService(), databaseService: makeDatabaseService())
//    }
//    
//    func makeVirtualStoreMerchantService() -> VirtualStoreMerchantServiceProtocol {
//        return VirtualStoreMerchantService(networkingManager: makeAuthorizedNetworkService(), databaseService: makeDatabaseService())
//    }
//
//    func makeIoTClientService() -> IoTClientServiceProtocol {
//        return IoTClientService(networkingManager: makeAuthorizedNetworkService())
//    }
    
    // MARK: - Private -
    
    private func makeNetworkService() -> Networking {
        return LystNetworkService(errorParser: makeErrorParser(), keychainService: makeKeychainService())
    }
    
    func makeAuthorizedNetworkService() -> AuthorizedNetworkService {
        return AuthorizedNetworkService(errorParser: makeErrorParser(), keychainService: makeKeychainService())
    }
    
    private func makeErrorParser() -> APIErrorParsing {
        return APIErrorParser()
    }
    
    func makeDatabaseService() -> DatabaseProtocol {
        return LystDatabaseService()
    }

}
