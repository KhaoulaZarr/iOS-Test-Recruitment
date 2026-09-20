//
//  PriceFormatting.swift
//  TheGoodCorner
//
//  Created by Khawla Zarrami on 20/09/2026.
//
import Foundation

enum PriceFormatting {
    static func string(for price: Double, locale: Locale = .current) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = "EUR"
        formatter.locale = locale

        return formatter.string(from: NSNumber(value: price))
            ?? "\(Int(price)) €"
    }
}
