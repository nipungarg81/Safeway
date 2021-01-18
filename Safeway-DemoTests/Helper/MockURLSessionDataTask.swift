//
//  MockURLSessionDataTask.swift
//  Safeway-DemoTests
//
//  Created by Nipun Garg on 1/17/21.
//

import Foundation
@testable import Safeway_Demo

class MockURLSessionDataTask: URLSessionDataTaskProtocol {
    private (set) var resumeWasCalled = false
    
    func resume() {
        resumeWasCalled = true
    }
}
