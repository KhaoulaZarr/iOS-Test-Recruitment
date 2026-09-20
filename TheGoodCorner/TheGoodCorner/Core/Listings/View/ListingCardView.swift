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
                listingImage
        
            VStack(alignment: .leading, spacing: 8) {
                listingTitleAndPrice
                categoryAndUrgentBadge
                listingDescription
            }
        }
        .padding(12)
        .background(
            cardBackground
        )
        .overlay {
            cardBorder
        }
        .accessibilityElement(children: .ignore)
        .accessibilityLabel(accessibilityDescription)
    }
    
    private var accessibilityDescription: String {
        var description = "\(listing.title), \(listing.price) euros, \(categoryName)"
        if listing.isUrgent {
            description += ", urgent listing"
        }
        return description
    }
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
private extension ListingCardView {
    
    var listingImage: some View {
        ListingImageView(imageURL: listing.thumbImageURL ?? "")
            .frame(width: 92, height: 92)
            .clipShape(RoundedRectangle(cornerRadius: 14))
            .accessibilityHidden(true)
    }
    
    var listingTitleAndPrice: some View {
        HStack(alignment: .top) {
            Text(listing.title)
                .font(.headline)
                .lineLimit(2)
                .multilineTextAlignment(.leading)
            Spacer()
            Text("\(listing.price) €")
                .font(.headline.weight(.semibold))
                .foregroundStyle(Color.appPrimary)
        }
    }
    
    var categoryAndUrgentBadge: some View {
        HStack(alignment: .top) {
            Text(categoryName.uppercased())
                .font(.caption.weight(.semibold))
                .foregroundStyle(Color.appPrimary)
            Spacer()
            
            if listing.isUrgent {
                Text("URGENT")
                    .font(.caption2.weight(.bold))
                    .foregroundStyle(Color.appPrimary)
                    .padding(.horizontal, 6)
                    .padding(.vertical, 3)
                    .background(
                        Capsule()
                            .fill(Color.appPrimary.opacity(0.1))
                    )
            }
        }
    }
    
    var listingDescription: some View {
        Text(listing.description)
            .font(.subheadline)
            .foregroundStyle(.secondary)
            .lineLimit(2)
    }
    
    var cardBackground: some View {
        RoundedRectangle(cornerRadius: 18, style: .continuous)
            .fill(Color.appPrimaryLight)
    }
    
    var cardBorder: some View {
        RoundedRectangle(cornerRadius: 18, style: .continuous)
            .stroke(Color.appPrimary.opacity(0.04), lineWidth: 1.0)
    }
}

#Preview {
    ListingCardView(
        listing: ListingCardView.previewListing,
        categoryName: ListingCardView.previewCategory.name
    )
}
