//
//  AppNetworkService.swift
//  Safeway-Demo
//
//  Created by Nipun Garg on 1/14/21.
//

import Foundation

import Foundation
import UIKit

enum AppNetworkServiceError : Error {
    case invalidResponse
}

let baseURL = "http://www.recipepuppy.com/api/"

class AppNetworkService {
    var httpClient = NetworkClient(session: URLSession.shared)
    
    func loadRecipes(for item: String, _ completion: @escaping ([Recipe]?, Error?) -> Void) {
        
        let jsonURLString = baseURL + "?q=" + item
        guard let url = URL(string: jsonURLString) else { return }
        
        httpClient.getData(url: url) { (data, error) in
            guard let data = data else { return }
            do {
                let searchRecipes = try JSONDecoder().decode(SearchRecipes.self, from: data)
                DispatchQueue.main.async {
                    completion(searchRecipes.recipes, nil)
                }
            } catch let jsonErr {
                print(jsonErr)
            }
        }
    }
}
