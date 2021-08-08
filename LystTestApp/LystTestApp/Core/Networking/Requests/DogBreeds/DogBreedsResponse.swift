//
//  DogBreedsResponse.swift
//  LystTestApp
//
//  Created by Mohsin Hussain on 08/08/2021.
//

import Foundation
import ObjectMapper
import LystNetworkManager
import LystModels

struct DogBreedsResponse: APIResponseProtocol {

    private(set) var dogsList: [DBDog] = []

    init(with json: Any) {
        guard let json = json as? [[String: Any]] else { return }
        setDataVersion(for: .dogs)
        dogsList = Mapper<DBDog>().mapArray(JSONArray: json)
    }
}
