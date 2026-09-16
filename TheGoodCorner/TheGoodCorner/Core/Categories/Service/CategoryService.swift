//
//  CategoryService.swift
//  TheGoodCorner
//
//  Created by Khawla Zarrami on 16/09/2026.
//
import Foundation

protocol CategoryServiceProtocol {
    func fetchCategories() async throws -> [Category]
}


struct CategoryService: CategoryServiceProtocol {
    private let client: APIClient
    
    init() {
        client = APIClient(baseURL: URLConstants.baseURL)
    }
    
    func fetchCategories() async throws -> [Category] {
        let requestModel = APIRequest<[Category]> (
            method: .get, path: .categories(.list)
        )
        let categories = try await client.execute(requestModel)
        return categories
    }
}
