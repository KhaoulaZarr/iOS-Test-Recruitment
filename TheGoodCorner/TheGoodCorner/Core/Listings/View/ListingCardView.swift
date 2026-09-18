//
//  ListingCardView.swift
//  TheGoodCorner
//
//  Created by Khawla Zarrami on 16/09/2026.
//

import SwiftUI

struct ListingCardView: View {
    let listing: Listing
    let categoryName: String
    
    var body: some View {
        HStack(alignment: .center, spacing: 18) {
            HStack(alignment: .center) {
                ListingImageView(imageURL: listing.thumbImageURL ?? "")
                    .frame(width: 92, height: 92)
                    .clipShape(RoundedRectangle(cornerRadius: 14))
            }
            VStack(alignment: .leading, spacing: 8) {
                HStack(alignment: .top) {
                    Text(listing.title)
                        .font(.headline)
                        .lineLimit(2)
                        .multilineTextAlignment(.leading)
                    Spacer()
                    Text("$ \(listing.price)")
                        .font(.headline.weight(.semibold))
                        .foregroundStyle(.blue)
                }
                HStack(alignment: .top) {
                    Text(categoryName.uppercased())
                        .font(.caption.weight(.semibold))
                        .foregroundStyle(.secondary)
                    Spacer()
                    
                    if listing.isUrgent {
                        Text("URGENT")
                            .font(.caption2.weight(.bold))
                            .foregroundStyle(.red)
                            .padding(.horizontal, 6)
                            .padding(.vertical, 3)
                            .background(
                                Capsule()
                                    .fill(.red.opacity(0.1))
                            )
                    }
                }
                Text(listing.description)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .lineLimit(2)
            }
        }
        .padding(12)
        .background(
            RoundedRectangle(cornerRadius: 18, style: .continuous)
                .fill(Color(.secondarySystemBackground))
        )
        .overlay {
            RoundedRectangle(cornerRadius: 18, style: .continuous)
                .stroke(Color.black.opacity(0.04), lineWidth: 1.0)
        }
    }
}

#Preview {
    ListingCardView(
        listing: ListingCardView.previewListing,
        categoryName: ListingCardView.previewCategory.name
    )
}

extension ListingCardView {
    
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
