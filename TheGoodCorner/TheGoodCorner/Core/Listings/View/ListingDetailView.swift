//
//  ListingDetailView.swift
//  TheGoodCorner
//
//  Created by Khawla Zarrami on 17/09/2026.
//
import SwiftUI

struct ListingDetailView: View {
    let listing: Listing
    let categoryName: String
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                ListingImageView(imageURL: listing.thumbImageURL ?? "")
                    .frame(height: 240)
                    .clipShape(RoundedRectangle(cornerRadius: 14))
                
                VStack(alignment: .leading, spacing: 10) {
                    listingInformation
                }
            }
            .padding(16)
            .navigationTitle("Listing")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}


#Preview {
    ListingDetailView(listing: ListingDetailView.previewListing, categoryName: ListingDetailView.previewCategory.name)
}

private extension ListingDetailView {
    @ViewBuilder
    var listingInformation: some View {
        Text(listing.title)
            .font(.title.bold())
        Text("$ \(listing.price)")
            .font(.title3.weight(.semibold))
            .foregroundStyle(.blue)
        Label(categoryName, systemImage: "tag")
            .font(.subheadline)
            .foregroundStyle(.secondary)
        Text(listing.description)
            .font(.body)
            .foregroundStyle(.primary)
    }
}

extension ListingDetailView {
    
    static var previewListing: Listing {
        let listingFeed = try! StaticJsonMapper.decode(
            file: "ListingsStaticData",
            type: ListingFeed.self
        )
        return listingFeed.items.first!
    }
    
    static var previewCategory: Category {
        let categories = try! StaticJsonMapper.decode(
            file: "CategoriesStaticData",
            type: [Category].self
        )
        return categories.first!
    }
}
