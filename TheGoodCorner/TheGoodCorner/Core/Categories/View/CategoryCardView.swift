//
//  CategoryCardView.swift
//  TheGoodCorner
//
//  Created by Khawla Zarrami on 17/09/2026.
//

import SwiftUI

struct CategoryCardView: View {
    let title: String
    let categoryID: Int?
    @Binding var selectedCategoryID: Int?
    
    var body: some View {
        Button {
            selectedCategoryID = categoryID
        } label: {
            HStack(spacing: 14) {
                Image(systemName: "tag.fill")
                    .foregroundStyle(.blue)
                    .frame(width:36, height: 36)
                    .background(.blue.opacity(0.1))
                    .clipShape(Circle())
                    .accessibilityHidden(true)
                Text(title)
                    .font(.body.weight(.medium))
                Spacer()
                Image(systemName: selectedCategoryID == categoryID
                      ? "checkmark.circle.fill"
                      : "circle")
                .font(.title3)
                .foregroundStyle(selectedCategoryID == categoryID
                                 ? .blue
                                 : .secondary)
                .accessibilityHidden(true)
            }
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(
                    selectedCategoryID == categoryID
                    ? Color.blue.opacity(0.08)
                    : Color(.secondarySystemBackground)
                )
        )
        .overlay {
            RoundedRectangle(cornerRadius: 16)
                .stroke(
                    selectedCategoryID == categoryID
                    ? Color.blue.opacity(0.4)
                    : Color.clear,
                    lineWidth: 1
                )
        }
        .buttonStyle(.plain)
        .accessibilityLabel(title)
        .accessibilityValue(
            selectedCategoryID == categoryID ? "Selected" : "Not selected"
        )
    }
}

#Preview {
    CategoryCardView(title: "Véhicule", categoryID: 1, selectedCategoryID: .constant(1))
}
