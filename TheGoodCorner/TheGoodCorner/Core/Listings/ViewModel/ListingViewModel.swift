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
    
    private let service: ListingServiceProtocol
    
    init(service: ListingServiceProtocol) {
        self.service = service
    }
    
    func loadListings() async {
        loadingState = .loading
        do {
            let feed = try await service.fetchListings()
            let products = feed.items
            loadingState = products.isEmpty ? .empty : .loaded(products)
        }catch {
            loadingState = .error(error.localizedDescription)
        }
    }
}
