//
//  ListingImageView.swift
//  TheGoodCorner
//
//  Created by Khawla Zarrami on 17/09/2026.
//

import SwiftUI

struct ListingImageView: View {
    let imageURL: String?
    let placeholderIconFont: Font
    
    var body: some View {
        Group {
            if let imageURL,
               let url = URL(string: imageURL) {
                AsyncImage(
                    url: url
                ) { phase in
                    switch phase {
                    case .empty:
                        loadingPlaceholder
                        
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()
                        
                    case .failure(_):
                        errorImageLoading()
                        
                    @unknown default:
                        imagePlaceholder
                    }
                }
            }
            else {
                imagePlaceholder
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }    
}

private extension ListingImageView {
    var imagePlaceholder: some View {
        RoundedRectangle(cornerRadius: 14)
            .fill(.gray.opacity(0.12))
            .overlay {
                Image(systemName: "photo")
                    .foregroundStyle(.secondary)
                    .font(placeholderIconFont)
            }
    }
    var loadingPlaceholder: some View {
        ZStack {
            imagePlaceholder
            ProgressView()
        }
    }
    
    func errorImageLoading() -> some View {
        VStack(spacing: 8) {
            Image(systemName: "photo.badge.exclamationmark")
                .foregroundStyle(.secondary)
                .font(placeholderIconFont)
            
            Text("Image unavailable")
                .font(.caption)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.gray.opacity(0.12))
        .accessibilityElement(children: .ignore)
        .accessibilityLabel("Image unavailable")
    }
}
