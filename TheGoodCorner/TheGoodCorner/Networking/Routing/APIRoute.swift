//
//  APIRoute.swift
//  TheGoodCorner
//
//  Created by Khawla Zarrami on 16/09/2026.
//

import Foundation

struct URLConstants {
    static let listingsURL: URL = URL(string: "http://127.0.0.1:8080")!
}
enum APIRoute {
    case listings(ListingEndpoint)
    
    var path: String {
        switch self {
        case .listings(let listingRoute):
            return listingRoute.path
        }
    }
}
