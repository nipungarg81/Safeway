//
//  HttpClientTests.swift
//  Safeway-DemoTests
//
//  Created by Nipun Garg on 1/17/21.
//

import XCTest
@testable import Safeway_Demo

class HttpClientTests: XCTestCase {
    
    var networkClient: NetworkClient!
    let session = MockURLSession()
    
    override func setUp() {
        super.setUp()
        networkClient = NetworkClient(session: session)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test_get_should_return_data() {
        let expectedData = "Hello World".data(using: .utf8)
        
        session.nextData = expectedData
        
        var actualData: Data?
        networkClient.getData(url: URL(string: "http://url")!) { (data, error) in
            actualData = data
        }
        
        XCTAssertNotNil(actualData)
    }    
}
