//
//  CategoryEndPoint.swift
//  TheGoodCorner
//
//  Created by Khawla Zarrami on 16/09/2026.
//
import Foundation

nonisolated
enum CategoryEndPoint{
    case list
    
    var path: String {
        switch self {
        case .list:
            "categories"
        }
    }
}
