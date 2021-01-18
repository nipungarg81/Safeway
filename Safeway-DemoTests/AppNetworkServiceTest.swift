//
//  AppNetworkServiceTest.swift
//  Safeway-DemoTests
//
//  Created by Nipun Garg on 1/17/21.
//

import XCTest
@testable import Safeway_Demo

class AppNetworkServiceTest: XCTestCase {
    var appNetworkService = MockAppNetworkService()
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test_recipe_count() {
        appNetworkService.loadRecipes(for: "onion") { recipe, error in
            guard let recipe = recipe else {
                fatalError("recipe is nil")
            }
            XCTAssert(recipe.count == 10)
        }
    }
}
