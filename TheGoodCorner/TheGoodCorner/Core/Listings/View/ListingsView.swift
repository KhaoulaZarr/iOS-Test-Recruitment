//
//  ListingsView.swift
//  TheGoodCorner
//
//  Created by Khawla Zarrami on 16/09/2026.
//

import SwiftUI

struct ListingsView: View {
    @StateObject private var viewModel: ListingViewModel
    @State private var showFilter: Bool = false
    
    init(
     ) {
         #if DEBUG
         if UITestingHelper.isUITesting {
             let mock: ListingServiceProtocol = UITestingHelper.isNetworkingSuccessful ? ListingServiceSuccessMock() : ListingServiceFailureMock()
             _viewModel = StateObject(
                wrappedValue: ListingViewModel(
                    listingService: mock,
                    categoryService: CategoryServiceSuccessMock()
                )
             )
         } else {
             _viewModel = StateObject(
                 wrappedValue: ListingViewModel(
                     listingService: ListingService(),
                     categoryService: CategoryService()
                    )
                 )
         }
         
         #else
         viewModel = StateObject(
             wrappedValue: ListingViewModel(
                 listingService: ListingService(),
                 categoryService: CategoryService()
                )
             )
         #endif
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
                                NavigationLink(value: listing) {
                                    ListingCardView(listing: listing, categoryName: viewModel.categoryName(for: listing.categoryId))
                                        .accessibilityIdentifier("item_\(listing.id)")
                                }
                                .buttonStyle(.plain)
                                
                            }
                        }
                        .padding()
                        .accessibilityIdentifier("listingList")
                    }
                }
            }
            .navigationTitle("Listings")
            .navigationDestination(
                for: Listing.self,
                destination: { listing in
                    ListingDetailView(
                        listing: listing,
                        categoryName: viewModel.categoryName(
                            for: listing.categoryId
                        )
                    )
                })
            .toolbar {
                ToolbarItemGroup(placement: .topBarTrailing) {
                    Button {
                        showFilter.toggle()
                    } label: {
                        Image(systemName: "line.3.horizontal.decrease.circle")
                            .foregroundStyle(Color.appPrimary)
                    }
                    .accessibilityLabel("Filter listings")
                    .accessibilityHint("Opens the filter to select a category")
                }
            }
            .sheet(isPresented: $showFilter, content: {
                CategoriesFilterView(viewModel: viewModel)
            })
            .refreshable {
                    await viewModel.loadListings()
                
            }
            .task {
                 if viewModel.loadingState == .idle {
                    await viewModel.loadListings()
                }
                
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
        VStack(spacing: 16) {
            Image(systemName: "exclamationmark.triangle")
                    .font(.largeTitle)
                    .foregroundStyle(.secondary)
                    .accessibilityHidden(true)
            Text(message)
                .font(.body)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
                .padding()
            Button("Retry") {
                    Task {
                       await viewModel.loadListings()
                    }
                }
                    .buttonStyle(.borderedProminent)
            
        }
        .padding()
    }
}
