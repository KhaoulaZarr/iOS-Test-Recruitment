//
//  APIClientTests.swift
//  TheGoodCornerTests
//
//  Created by Khawla Zarrami on 18/09/2026.
//

import XCTest
@testable import TheGoodCorner

final class APIClientTests: XCTestCase {
    private var url: URL!
    private var session: URLSession!
    
    override func setUp() {
        super.setUp()
        url = URLConstants.baseURL
        
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockUrlSessionProtocol.self]
        session = URLSession(configuration: configuration)
    }
    
    override func tearDown() {
        super.tearDown()
        session = nil
        url = nil
    }
    
    // When the server returns HTTP 200 and valid JSON,does APIClient correctly decodes the response?
    @MainActor
    func test_with_successful_response_response_is_valid() async throws {
        guard let path = Bundle.main.path(forResource: "ListingsStaticData", ofType: "json"),
              let data = FileManager.default.contents(atPath: path) else {
            XCTFail("Failed to get the static listings file")
            return
        }
        MockUrlSessionProtocol.loadingHandler = {
            let response = HTTPURLResponse(url: self.url,
                                           statusCode: 200,
                                           httpVersion: nil,
                                           headerFields: nil
            )
            
            return (response!, data)
        }
        
        let client = APIClient(
            baseURL: url,
            session: session
        )
        
        let requestModel = APIRequest<ListingFeed>(
            method: .get,
            path: .listings(.list)
        )
        let res = try await client.execute(requestModel)
        
        let staticJSON = try StaticJsonMapper.decode(file: "ListingsStaticData", type: ListingFeed.self)
        XCTAssertEqual(res, staticJSON, "The returned response should be decoded properly")
    }
    
    // When the server return an invalid HTTP status code, does API Client throws the expected NetworkingError ?
    @MainActor
    func test_with_unsuccessful_response_code_in_invalid_range_is_invalid() async {
        let invalidStatusCode = 400
        
        MockUrlSessionProtocol.loadingHandler = {
            let response = HTTPURLResponse(url: self.url,
                                           statusCode: invalidStatusCode,
                                           httpVersion: nil,
                                           headerFields: nil
            )
            
            return (response!, nil)
        }
        
        let client = APIClient(
            baseURL: url,
            session: session
        )
        
        let requestModel = APIRequest<ListingFeed>(
            method: .get,
            path: .listings(.list)
        )
        
        do {
            _ = try await client.execute(requestModel)
        }catch {
            guard let networkingError = error as? NetworkError else {
                XCTFail("Got the wrong type of error, expecting NetworkingError")
                return
            }
            XCTAssertEqual(networkingError, NetworkError.httpStatus(code: invalidStatusCode), "Error should be a networking error which throws an invalid status code")
        }
    }
    
    // When the server returns an invalid HTTP status code with no data, does API Client throw the expected NetworkingError for an EmptyResponse
    @MainActor
    func test_with_unsuccessful_response_code_void_in_invalid_range_is_invalid() async {
        let invalidStatusCode = 400
        
        MockUrlSessionProtocol.loadingHandler = {
            let response = HTTPURLResponse(url: self.url,
                                           statusCode: invalidStatusCode,
                                           httpVersion: nil,
                                           headerFields: nil
            )
            
            return (response!, nil)
        }
        
        let client = APIClient(
            baseURL: url,
            session: session
        )
        
        let requestModel = APIRequest<EmptyResponse>(
            method: .get,
            path: .listings(.list)
        )
        
        do {
            _ = try await client.execute(requestModel)
        }catch {
            guard let networkingError = error as? NetworkError else {
                XCTFail("Got the wrong type of error, expecting NetworkingError")
                return
            }
            XCTAssertEqual(networkingError, NetworkError.httpStatus(code: invalidStatusCode), "Error should be a networking error which throws an invalid status code")
        }
    }
}
