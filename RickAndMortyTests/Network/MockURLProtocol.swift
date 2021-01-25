//
//  MockURLProtocol.swift
//  RickAndMortyTests
//
//  Created by Rafael Costa on 23/01/21.
//

import Foundation

class MockURLProtocol: URLProtocol {
    static var mock: ((URLRequest) throws -> (HTTPURLResponse, Data?))?
    
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    override func startLoading() {
        guard let mock = MockURLProtocol.mock else {
            fatalError("Mock not set.")
        }
        
        do {
            let (response, data) = try mock(request)
            
            self.client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            
            if let _data = data {
                self.client?.urlProtocol(self, didLoad: _data)
            }
            
            self.client?.urlProtocolDidFinishLoading(self)
        } catch {
            // 6. Notify received error.
            self.client?.urlProtocol(self, didFailWithError: error)
        }
    }
    
    override func stopLoading() {
        
    }
}
