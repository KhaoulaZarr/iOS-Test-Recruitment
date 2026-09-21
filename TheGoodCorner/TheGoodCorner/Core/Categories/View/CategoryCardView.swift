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
            withAnimation(.snappy) {
                selectedCategoryID = categoryID
            }
            
        } label: {
            HStack(spacing: 14) {

                Image(systemName: "tag.fill")
                    .foregroundStyle(
                        selectedCategoryID == categoryID
                        ? .white
                        : Color.appPrimary
                    )
                    .frame(width: 36, height: 36)
                    .background(.blue.opacity(0.1))
                    .clipShape(Circle())
                    .accessibilityHidden(true)

                Text(title)
                    .font(.body.weight(.medium))

                Spacer()
                
                Image(systemName: "checkmark")
                    .font(.title3)
                    .foregroundStyle(Color.appPrimary)
                    .opacity(selectedCategoryID == categoryID ? 1 : 0)
                    .accessibilityHidden(true)
            }
            .padding(16)
            .frame(maxWidth: .infinity)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(
                        selectedCategoryID == categoryID
                        ? Color.appPrimaryLight
                        : Color(.secondarySystemBackground)
                    )
            )
            .overlay {
                RoundedRectangle(cornerRadius: 16)
                    .stroke(
                        selectedCategoryID == categoryID
                        ? Color.appPrimary.opacity(0.4)
                        : Color.clear,
                        lineWidth: 1
                    )
            }
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        .accessibilityIdentifier("category_\(categoryID ?? 0)")
        .accessibilityLabel(title)
        .accessibilityValue(
            selectedCategoryID == categoryID
            ? "Selected"
            : "Not selected"
        )
    }
}

#Preview {
    CategoryCardView(title: "Véhicule", categoryID: 1, selectedCategoryID: .constant(1))
}
