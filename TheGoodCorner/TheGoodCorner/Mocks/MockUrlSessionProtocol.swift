//
//  MockUrlSessionProtocol.swift
//  TheGoodCorner
//
//  Created by Khawla Zarrami on 18/09/2026.
//

#if DEBUG
import Foundation

// URLSession normally goes to the server, but here you replace the networking layer with MockUrlSessionProtocol, which returns fake responses.
class MockUrlSessionProtocol: URLProtocol {
    
    static var loadingHandler: (() -> (HTTPURLResponse, Data?))? // When a request happens, what response should I return?
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    override func startLoading() {
        guard let handler = MockUrlSessionProtocol.loadingHandler else {
            fatalError("Loading handler is not set.")
        }
        let (response, data) = handler()
        client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
        if let data = data {
            client?.urlProtocol(self, didLoad: data)
        }
        client?.urlProtocolDidFinishLoading(self)
    }
    
    override func stopLoading() {
        
    }
}
#endif
