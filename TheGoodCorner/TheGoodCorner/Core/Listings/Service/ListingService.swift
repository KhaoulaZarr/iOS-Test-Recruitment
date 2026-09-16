//
//  ListingService.swift
//  TheGoodCorner
//
//  Created by Khawla Zarrami on 16/09/2026.
//
import Foundation

protocol ListingServiceProtocol {
    func fetchListings() async throws -> ListingFeed
}

struct ListingService: ListingServiceProtocol {
    private let client: APIClient
    
    init() {
        client = APIClient(baseURL: URLConstants.listingsURL)
    }
    
    func fetchListings() async throws -> ListingFeed {
        let requestModel = APIRequest<ListingFeed>(method: .get, path: .listings(.list))
        let feed = try await client.execute(requestModel)
        return feed
    }
}
