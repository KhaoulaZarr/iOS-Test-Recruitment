//
//  CategoriesFilterView.swift
//  TheGoodCorner
//
//  Created by Khawla Zarrami on 17/09/2026.
//

import SwiftUI

struct CategoriesFilterView: View {
    @ObservedObject var viewModel: ListingViewModel
    @State private var selectedCategoryID: Int?
    @Environment(\.dismiss) var dismiss
    
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
                selectedCategoryID: $selectedCategoryID
            )
            ForEach(
                viewModel.categories
            ) { category in
                CategoryCardView(
                    title: category.name,
                    categoryID: category.id,
                    selectedCategoryID: $selectedCategoryID
                )
            }
        }
    }
    
    var applyButton: some View {
        Button {
            viewModel.filterByCategory(selectedCategoryID)
            dismiss()
        } label: {
            Text("Apply Filter")
                .font(.headline)
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
                .frame(height: 52)
                .background(.blue)
                .clipShape(RoundedRectangle(cornerRadius: 16))
        }
    }
}
