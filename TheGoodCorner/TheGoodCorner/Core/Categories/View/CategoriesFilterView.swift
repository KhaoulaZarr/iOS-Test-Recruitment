//
//  CategoriesFilterView.swift
//  TheGoodCorner
//
//  Created by Khawla Zarrami on 17/09/2026.
//

import SwiftUI

struct CategoriesFilterView: View {
    @ObservedObject var viewModel: ListingViewModel
    @Environment(\.dismiss) var dismiss
    @State private var temporarySelectedCategoryID: Int?
    
    init(viewModel: ListingViewModel) {
        self.viewModel = viewModel
            _temporarySelectedCategoryID = State(
                initialValue: viewModel.selectedCategoryID
            )
        }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    header
                    categoryList
                    applyButton
                }
                .padding(16)
            }
            .navigationTitle("Filters")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                        Button("Reset") {
                            temporarySelectedCategoryID = nil
                        }
                    }
            }
        }
        
    }
    
}
#Preview {
    CategoriesFilterView(viewModel:ListingViewModel(listingService: ListingService(), categoryService: CategoryService()) )
}

private extension CategoriesFilterView {
    var header: some View {
        VStack(alignment: .leading, spacing:6) {
            Text("Category")
                .font(.title2.bold())
            Text("Choose a category to filter your listings")
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
    }
    
    var categoryList: some View {
        VStack(spacing: 12) {
            CategoryCardView(
                title: "All categories",
                categoryID: nil,
                selectedCategoryID: $temporarySelectedCategoryID
            )
            ForEach(
                viewModel.categories
            ) { category in
                CategoryCardView(
                    title: category.name,
                    categoryID: category.id,
                    selectedCategoryID: $temporarySelectedCategoryID
                )
            }
        }
    }
    
    var applyButton: some View {
        Button {
            viewModel.filterByCategory(temporarySelectedCategoryID)
            dismiss()
        } label: {
            Text("Apply Filter")
                .font(.headline)
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 16)
                .background(.blue)
                .clipShape(RoundedRectangle(cornerRadius: 16))
        }
    }
}
