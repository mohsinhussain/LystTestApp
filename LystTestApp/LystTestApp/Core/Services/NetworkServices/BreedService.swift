//
//  BreedService.swift
//  Lyst Test App
//
//  Created by Mohsin Hussain on 07/08/2021.
//

import Foundation
import LystModels
import LystNetworkManager
import LystDatabaseManager

protocol BreedServiceProtocol {
    func fetchDogsFromLocal(completion: @escaping ([Dog]) -> Void)
    func fetchDogs(completion: @escaping ([Dog], BackendError?) -> Void)
    func searchDogsFromLocal(queryString: String, completion: @escaping ([Dog]) -> Void)
}


class BreedService {
    let networkingManager: AuthorizedNetworkService
    let databaseService: DatabaseProtocol

    init(networkingManager: AuthorizedNetworkService, databaseService: DatabaseProtocol) {
        self.networkingManager = networkingManager
        self.databaseService = databaseService
    }
    
    func fetchDogsFromDatabase() -> [Dog] {
        let version = getDataVersion(for: .dogs)
        let predicate = NSPredicate(format: "version >= \(version)")
        let dbDogs: [DBDog] = databaseService.findWithSort(satisfying: predicate, by: "id", isAscending: true)
        return dbDogs.map { Dog(from: $0) }
    }
    
    func searchDogsFromDatabase(query: String) -> [Dog] {
        let version = getDataVersion(for: .dogs)
        let predicate = NSPredicate(format: "name CONTAINS[c] '\(query)' AND version >= \(version)")
        let dbDogs: [DBDog] = databaseService.findWithSort(satisfying: predicate, by: "id", isAscending: true)
        return dbDogs.map { Dog(from: $0) }
    }
    
    func saveDogsToDatabase(_ dogs: [DBDog]) {
        guard !dogs.isEmpty else { return }
        databaseService.save(dogs)
    }
}

extension BreedService: BreedServiceProtocol {
    func searchDogsFromLocal(queryString: String, completion: @escaping ([Dog]) -> Void) {
        completion(searchDogsFromDatabase(query: queryString))
    }
    
    func fetchDogsFromLocal(completion: @escaping ([Dog]) -> Void) {
        completion(fetchDogsFromDatabase())
    }
    
    func fetchDogs(completion: @escaping ([Dog], BackendError?) -> Void) {
        guard InternetObserver.shared.isOnline else {
            completion(fetchDogsFromDatabase(), nil)
            return
        }

        networkingManager.executeAuthorizedRequest(DogBreedsRequest(), completion: { [weak self] (response: DogBreedsResponse?, error) in
                self?.saveDogsToDatabase(response?.dogsList ?? [])
                completion(self?.fetchDogsFromDatabase() ?? [], error as? BackendError)
            })
    }
    
    
}
