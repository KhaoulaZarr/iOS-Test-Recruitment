//
//  ListingsView.swift
//  TheGoodCorner
//
//  Created by Khawla Zarrami on 16/09/2026.
//

import SwiftUI

struct ListingsView: View {
    @StateObject private var viewModel: ListingViewModel
    
    init(
        listingsService: ListingServiceProtocol = ListingService(),
        categoriesService: CategoryServiceProtocol = CategoryService()
    ) {
        _viewModel = StateObject(
            wrappedValue: ListingViewModel(
                listingService: listingsService,
                categoryService: categoriesService
            )
        )
    }
    
    var body: some View {
        NavigationStack {
            Group {
                switch viewModel.loadingState {
                case .idle, .loading:
                    ProgressView()
                case .empty:
                    emptyListingView
                case .error(let errorMessage):
                    errorListingView(message: errorMessage)
                case .loaded(let listings):
                    ScrollView {
                        LazyVStack(spacing: 16) {
                            ForEach(listings) { listing in
                        
                                ListingCardView(listing: listing, categoryName: viewModel.categoryName(for: listing.categoryId))
                            }
                        }
                        .padding()
                    }
                }
            }
            .navigationTitle("Listings")
            .refreshable {
                await viewModel.loadListings()
            }
            .task {
                await viewModel.loadListings()
            }
        }
    }

}

#Preview {
    ListingsView()
}

private extension ListingsView {
    
    var emptyListingView: some View {
        Text("No listings to display")
            .font(.body)
            .foregroundStyle(.secondary)
            .multilineTextAlignment(.center)
            .padding()
    }
    
    func errorListingView(message: String) -> some View {
        Text(message)
         .font(.body)
          .foregroundStyle(.secondary).multilineTextAlignment(.center) .padding()
    }
}
