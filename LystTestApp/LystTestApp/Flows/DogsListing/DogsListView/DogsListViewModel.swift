//
//  DogsListViewModel.swift
//  Lyst Test App
//
//  Created by Mohsin Hussain on 07/08/2021.
//

import Foundation
import LystModels

class DogsListViewModel: AbstractViewModel {
    private let breedService = ServicesFactory.shared.makeBreedService()
    private var dogsList: [Dog] = []
}

// MARK: - Functions -

extension DogsListViewModel {
    
    func getDogs() -> [Dog] {
        return dogsList
    }
    
    func fetchDogsList() {
        breedService.fetchDogsFromLocal { [weak self] (dogsList) in
            self?.dogsList = dogsList
            self?.delegate?.updateUI(status: .success)

            if dogsList.count == 0 {
                self?.delegate?.updateUI(status: .fetching)
            }

            self?.breedService.fetchDogs { [weak self] (dogsList, error) in
                if error != nil {
                    self?.delegate?.updateUI(status: .error(message: "Error loading the dogs"))
                } else {
                    self?.dogsList = dogsList
                    self?.delegate?.updateUI(status: .success)
                }
            }
        }
    }
    
    func getDog(at row: Int) -> Dog? {
        guard row < dogsList.count else { return nil }
        
        return dogsList[row]
    }
    
}
