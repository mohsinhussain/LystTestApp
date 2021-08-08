//
//  DogBreedsRequest.swift
//  LystTestApp
//
//  Created by Mohsin Hussain on 08/08/2021.
//

import Foundation
import LystNetworkManager

struct DogBreedsRequest: APIRequestProtocol {
    var xAPIKey: String = AppConfiguration.shared.getApiKey()
    var endpoint: String { return API.dogBreedsAPI.getBreeds.fullPath() }
    var method: HTTPMethod { return .get }
}
