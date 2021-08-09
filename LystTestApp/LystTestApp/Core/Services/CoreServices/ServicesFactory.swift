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

    func makeBreedService() -> BreedServiceProtocol {
        return BreedService(networkingManager: makeAuthorizedNetworkService(), databaseService: makeDatabaseService())
    }
    
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
