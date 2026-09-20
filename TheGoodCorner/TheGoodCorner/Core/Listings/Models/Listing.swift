//
//  Listing.swift
//  TheGoodCorner
//
//  Created by Khawla Zarrami on 16/09/2026.
//

import Foundation

nonisolated // By default default actor isolation is MainActor nonisolated means The function does not inherit main-actor isolation from the default setting.
struct ListingFeed: Codable, Equatable {
    let total: Int
    let page: Int
    let limit: Int
    let hasMore: Bool
    let items: [Listing]

    enum CodingKeys: String, CodingKey {
        case total
        case page
        case limit
        case hasMore = "has_more"
        case items
    }
}

nonisolated
struct Listing: Codable, Identifiable, Hashable {
    let id: Int
    let isUrgent: Bool
    let categoryId: Int
    let title: String
    let imagesURL: ImagesURL?
    let price: Double
    let description: String
    let creationDate: String

    enum CodingKeys: String, CodingKey {
        case id
        case isUrgent = "is_urgent"
        case categoryId = "category_id"
        case title
        case imagesURL = "images_url"
        case price
        case description
        case creationDate = "creation_date"
    }
    
    var smallImageURL: String? {
        guard let small = imagesURL?.small else {
            return nil
        }
        return "\(URLConstants.baseURL)\(small)"
    }
    
    var thumbImageURL: String? {
        guard let thumb = imagesURL?.thumb else {
            return nil
        }
        return "\(URLConstants.baseURL)\(thumb)"
    }
}

struct ImagesURL: Codable, Hashable {
    let small: String?
    let thumb: String?
}
