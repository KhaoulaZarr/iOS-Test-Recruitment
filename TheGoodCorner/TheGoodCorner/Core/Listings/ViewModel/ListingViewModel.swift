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
    @Published private(set) var categories: [Category] = []
    
    private let listingService: ListingServiceProtocol
    private let categoryService: CategoryServiceProtocol
    private var categoriesByID: [Int: String] = [:]
    private var allListings: [Listing] = []
    
    init(listingService: ListingServiceProtocol, categoryService: CategoryServiceProtocol) {
        self.listingService = listingService
        self.categoryService = categoryService
    }
    
    func loadListings() async {
        loadingState = .loading
        
        do {
            async let listingsTask = listingService.fetchListings()
            async let categoriesTask = categoryService.fetchCategories()
            
            let (feed, fetchedCategories) = try await (
                listingsTask,
                categoriesTask
            )
            
            categories = fetchedCategories
            
            categoriesByID = Dictionary(
                uniqueKeysWithValues: fetchedCategories.map {
                    ($0.id, $0.name)
                }
            )
            
            allListings = feed.items
            loadingState = allListings.isEmpty
            ? .empty
            : .loaded(allListings)
            
        } catch {
            loadingState = .error(error.localizedDescription)
        }
    }
    
    func categoryName(for categoryID:Int) -> String {
        categoriesByID[categoryID] ?? "Unknown category"
    }
    
    func filterByCategory(_ categoryID: Int?) {
        guard let categoryID else {
            loadingState = allListings.isEmpty
            ? .empty
            : .loaded(allListings)
            return
        }
        
        let filteredListings = allListings.filter {
            $0.categoryId == categoryID
        }
        
        loadingState = filteredListings.isEmpty
        ? .empty
        : .loaded(filteredListings)
    }
}
