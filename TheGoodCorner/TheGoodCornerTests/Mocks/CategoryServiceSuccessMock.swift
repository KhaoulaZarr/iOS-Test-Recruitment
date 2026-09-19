//
//  CategoryServiceSuccessMock.swift
//  TheGoodCorner
//
//  Created by Khawla Zarrami on 19/09/2026.
//

import Foundation
@testable import TheGoodCorner

struct CategoryServiceSuccessMock: CategoryServiceProtocol {
    
    func fetchCategories() async throws -> [TheGoodCorner.Category] {
        return try StaticJsonMapper.decode(file: "CategoriesStaticData", type: [TheGoodCorner.Category].self)
    }
}
