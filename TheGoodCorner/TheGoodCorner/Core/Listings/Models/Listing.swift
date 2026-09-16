//
//  Listing.swift
//  TheGoodCorner
//
//  Created by Khawla Zarrami on 16/09/2026.
//

import Foundation

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

struct Listing: Codable, Identifiable, Hashable {
    let id: Int
    let isUrgent: Bool
    let categoryId: Int
    let title: String
    let imagesURL: ImagesURL?
    let price: Int
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

extension Listing {

    static let mockListings: [Listing] = [

        Listing(
            id: 1,
            isUrgent: true,
            categoryId: 1,
            title: "BMW Série 3",
            imagesURL: ImagesURL(
                small: "/images/ad-small/5877f940762daca3548cb19d89324098fb116356.jpg",
                thumb: "/images/ad-small/5877f940762daca3548cb19d89324098fb116356.jpg"
            ),
            price: 18500,
            description: "BMW Série 3 en très bon état.",
            creationDate: "2026-09-15"
        ),

        Listing(
            id: 2,
            isUrgent: false,
            categoryId: 2,
            title: "Appartement à vendre",
            imagesURL: ImagesURL(
                small: "/images/ad-small/5877f940762daca3548cb19d89324098fb116356.jpg",
                thumb: "/images/ad-small/5877f940762daca3548cb19d89324098fb116356.jpg"
            ),
            price: 250000,
            description: "Appartement lumineux situé au centre-ville.",
            creationDate: "2026-09-14"
        ),

        Listing(
            id: 3,
            isUrgent: false,
            categoryId: 3,
            title: "MacBook Pro",
            imagesURL: ImagesURL(
                small: "/images/ad-small/5877f940762daca3548cb19d89324098fb116356.jpg",
                thumb: "/images/ad-small/5877f940762daca3548cb19d89324098fb116356.jpg"
            ),
            price: 3200,
            description: "MacBook Pro en excellent état.",
            creationDate: "2026-09-13"
        ),

        Listing(
            id: 4,
            isUrgent: true,
            categoryId: 4,
            title: "Vélo de course",
            imagesURL: ImagesURL(
                small: "/images/ad-small/5877f940762daca3548cb19d89324098fb116356.jpg",
                thumb: "/images/ad-small/5877f940762daca3548cb19d89324098fb116356.jpg"
            ),
            price: 1500,
            description: "Vélo de course léger et performant.",
            creationDate: "2026-09-12"
        )
    ]
}
