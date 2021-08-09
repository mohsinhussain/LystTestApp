//
//  DogDetailViewModel.swift
//  LystTestApp
//
//  Created by Mohsin Hussain on 09/08/2021.
//

import Foundation
import LystModels

class DogDetailViewModel: AbstractViewModel {
    private var dog: Dog?
}

extension DogDetailViewModel {
    func getDog() -> Dog? {
        return dog
    }
    
    func setDog(dog: Dog) {
        self.dog = dog
    }
}
