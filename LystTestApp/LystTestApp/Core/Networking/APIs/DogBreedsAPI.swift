//
//  DogBreedsAPI.swift
//  LystTestApp
//
//  Created by Mohsin Hussain on 08/08/2021.
//

import Foundation

enum DogBreedsAPI: String {

    // Search Breeds
    case searchBreeds = "breeds/search?q=%@"
    
    // Get Breeds
    case getBreeds = "breeds?limit=%@&page=%@&order=Asc"
//    case getOrdersHistory = "Order/OrderHistory?pagenumber=%d&pagesize=%d&statusIds=%@"
    
    /** Contains the full path to the endpoint */
    func fullPath(withParameters parameters: CVarArg...) -> String {
        var endpoint = self.rawValue
        
        if parameters.count > 0 {
            endpoint = String(format: endpoint, arguments: parameters)
        }
        
        return "\(AppConfiguration.shared.getBaseURL())/\(endpoint)"
    }
    
}
