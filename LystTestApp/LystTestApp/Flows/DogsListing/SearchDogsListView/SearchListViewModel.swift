//
//  SearchListViewModel.swift
//  LystTestApp
//
//  Created by Mohsin Hussain on 09/08/2021.
//

import Foundation
import LystModels

class SearchListViewModel: AbstractViewModel {
    private let breedService = ServicesFactory.shared.makeBreedService()
    private var dogsList: [Dog] = []
    private var currentQueryString: String = ""
}

// MARK: - Functions -

extension SearchListViewModel {
    
    func getDogs() -> [Dog] {
        return dogsList
    }
    
    func searchDogs(query: String) {
        guard !query.isEmpty else {
            return
        }
        
        if dogsList.count == 0 {
            delegate?.updateUI(status: .fetching)
        }
                
        if currentQueryString != query { // Reset Data
            dogsList = []
        }
        
        breedService.searchDogsFromLocal(queryString: query) { [weak self] (dogsList) in
            
            self?.currentQueryString = query
            self?.dogsList = dogsList
            self?.delegate?.updateUI(status: .success)
        }
    }
    
    func getDog(at row: Int) -> Dog? {
        guard row < dogsList.count else { return nil }
        
        return dogsList[row]
    }
    
    func resetDogsData() {
        guard dogsList.count > 0 else {
            return
        }
        dogsList = []
        delegate?.updateUI(status: .success)
    }
    
}
