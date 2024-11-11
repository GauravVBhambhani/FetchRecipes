//
//  MockURLProtocol.swift
//  FetchRecipesTests
//
//  Created by Gaurav Bhambhani on 11/11/24.
//

import Foundation

class MockURLProtocol: URLProtocol {
    static var responseData: Data?
    static var responseError: Error?
    
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    override func startLoading() {
        if let error = MockURLProtocol.responseError {
            client?.urlProtocol(self, didFailWithError: error)
            
        } else {
            client?.urlProtocol(self, didLoad: MockURLProtocol.responseData ?? Data())
        }
        client?.urlProtocolDidFinishLoading(self)
    }
    
    override func stopLoading() {}
}
