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
            VStack(spacing: 0) {
                ScrollView {
                    VStack(alignment: .leading, spacing: 24) {
                        header
                        categorySection
                        categoryList
                    }
                    .padding(20)
                }
                bottomActions
            }
            .background(Color(.systemGroupedBackground))
            .navigationTitle("Filters")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                     cancel
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
        VStack(alignment: .leading, spacing:8) {
            Text("Filter listings")
                .font(.title2.weight(.bold))
                .foregroundStyle(Color.appPrimary)
            Text("Choose a category to filter your listings")
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
    }
    
    var categorySection:some View {
        HStack {
            Text("Category")
                .font(.headline)
            
            Spacer()
            
            if temporarySelectedCategoryID != nil {
                Text("1 selected")
                    .font(.caption.weight(.medium))
                    .foregroundStyle(Color.appPrimary)
            }
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
    
    var bottomActions: some View {
        
        VStack(spacing: 12) {
            Divider()
            HStack(spacing: 12) {
                
                Button("Reset") {
                    
                    withAnimation(.snappy) {
                        temporarySelectedCategoryID = nil
                    }
                }
                .buttonStyle(.bordered)
                .tint(.appPrimary)
                .frame(maxWidth: .infinity)
                .shadow(
                    color: Color.black.opacity(0.04),
                    radius: 3,
                    x: 0,
                    y: 2
                )
                
                Button {
                    viewModel.filterByCategory(
                        temporarySelectedCategoryID
                    )
                    
                    dismiss()
                    
                } label: {
                    
                    Text("Apply Filter")
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                .tint(.appPrimary)
                .shadow(
                    color: Color.appPrimary.opacity(0.25),
                    radius: 6,
                    x: 0,
                    y: 3
                )
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 12)
        }
        .background(.background)
    }
    
    var cancel:some View {
        Button {
            dismiss()
        } label: {
            Image(systemName: "xmark")
                .font(.system(size: 14,weight: .semibold))
                .font(.system(size: 14, weight: .semibold))
                .foregroundStyle(Color.appPrimary)
        }
        .accessibilityLabel("Close filter")
        .accessibilityHint("Closes the filter screen without applying changes")
    }
}
