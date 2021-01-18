//
//  MockAppNetworkService.swift
//  Safeway-DemoTests
//
//  Created by Nipun Garg on 1/17/21.
//

import Foundation
@testable import Safeway_Demo

class MockAppNetworkService: AppNetworkService {
    override init() {
        super.init()
        let session = MockURLSession()
        httpClient = NetworkClient(session: session)
        
        let expectedData = loadData()
        session.nextData = expectedData
    }
    
    func loadData() -> Data? {
        guard let path = Bundle(for: type(of: self)).path(forResource: "testData", ofType: "json") else {
            fatalError("UnitTestData.json not found")
        }
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            return data
        } catch {
            print("error")
        }
        return nil
    }    
}
