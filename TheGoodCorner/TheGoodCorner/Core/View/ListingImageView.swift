//
//  ListingImageView.swift
//  TheGoodCorner
//
//  Created by Khawla Zarrami on 17/09/2026.
//

import SwiftUI

struct ListingImageView: View {
    let imageURL: String?
    
    var body: some View {
        AsyncImage(
         url: URL(string: imageURL ?? "")
        ) { phase in
            switch phase {
            case .empty:
                imagePlaceholder

            case .success(let image):
                image
                    .resizable()
                    .scaledToFill()

            case .failure(let error):
                errorImageLoading(
                    message: error.localizedDescription
                )

            @unknown default:
                Text("Unknown")
                .foregroundColor(.gray)
            }
        }
    }
}

private extension ListingImageView {
    var imagePlaceholder: some View {
       ZStack {
           RoundedRectangle(cornerRadius: 14)
               .fill(.gray.opacity(0.12))

           ProgressView()
       }
   }
    
    func errorImageLoading(message: String) -> some View {
        VStack(spacing: 16) {
            Image(systemName: "xmark.octagon.fill")
            .foregroundColor(.red)
              Text(message)
               .multilineTextAlignment(.center)
        }
    }
}
