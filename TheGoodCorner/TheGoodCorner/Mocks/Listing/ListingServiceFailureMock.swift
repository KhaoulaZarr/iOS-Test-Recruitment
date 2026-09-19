//
//  ListingServiceFailureMock.swift
//  TheGoodCorner
//
//  Created by Khawla Zarrami on 19/09/2026.
//

#if DEBUG
import Foundation

struct ListingServiceFailureMock: ListingServiceProtocol {
    
    func fetchListings() async throws -> TheGoodCorner.ListingFeed {
        throw NetworkError.invalidResponse
    }
}
#endif
