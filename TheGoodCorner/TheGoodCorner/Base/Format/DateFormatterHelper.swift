//
//  DateFormatterHelper.swift.swift
//  TheGoodCorner
//
//  Created by Khawla Zarrami on 21/09/2026.
//
import Foundation

enum DateFormatterHelper {

    private static let isoParser: ISO8601DateFormatter = {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime]
        return formatter
    }()

    static func format(
        apiDate string: String,
        locale: Locale = .current
    ) -> String {
        guard let date = isoParser.date(from: string) else {
            return string
        }

        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        formatter.locale = locale

        return formatter.string(from: date)
    }
}
