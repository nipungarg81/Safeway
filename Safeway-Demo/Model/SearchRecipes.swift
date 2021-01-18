//
//  SearchRecipes.swift
//  Safeway-Demo
//
//  Created by Nipun Garg on 1/14/21.
//

import Foundation

struct SearchRecipes: Decodable {
    let recipes: [Recipe]?
    
    private enum CodingKeys: String, CodingKey {
        case recipes = "results"
    }
}

struct Recipe: Decodable {
    let title: String?
    let href: String?
    let ingredients: String?
    let thumbnail: String?
}
