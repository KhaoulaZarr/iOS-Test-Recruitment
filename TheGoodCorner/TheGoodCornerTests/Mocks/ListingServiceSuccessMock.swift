//
//  ListingServiceSuccessMock.swift
//  TheGoodCorner
//
//  Created by Khawla Zarrami on 19/09/2026.
//

import Foundation
@testable import TheGoodCorner

struct ListingServiceSuccessMock: ListingServiceProtocol {
    func fetchListings() async throws -> TheGoodCorner.ListingFeed {
        return try StaticJsonMapper.decode(file: "ListingsStaticData", type: ListingFeed.self)
    }
}
