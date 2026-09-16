//
//  ListingViewModel.swift
//  TheGoodCorner
//
//  Created by Khawla Zarrami on 16/09/2026.
//

import Foundation
import Combine

final class ListingViewModel: ObservableObject  {
    @Published private(set) var loadingState: LoadingState<[Listing]> = .idle
    
    private let listingService: ListingServiceProtocol
    private let categoryService: CategoryServiceProtocol
    private var categoriesByID: [Int: String] = [:]
    
    init(listingService: ListingServiceProtocol, categoryService: CategoryServiceProtocol) {
        self.listingService = listingService
        self.categoryService = categoryService
    }
    
    func loadListings() async {
        loadingState = .loading
        do {
            async let listingsTask  = try await listingService.fetchListings()
            async let categoriesTask = try await categoryService.fetchCategories()
            let (feed, categories) = try await (listingsTask, categoriesTask)
            categoriesByID = Dictionary(uniqueKeysWithValues: categories.map {($0.id, $0.name)})
            
            let listings = feed.items
            
            loadingState = listings.isEmpty ? .empty : .loaded(listings)
        }catch {
            loadingState = .error(error.localizedDescription)
        }
    }
    
    func categoryName(for categoryID:Int) -> String {
        categoriesByID[categoryID] ?? "Unknown category"
    }
}
