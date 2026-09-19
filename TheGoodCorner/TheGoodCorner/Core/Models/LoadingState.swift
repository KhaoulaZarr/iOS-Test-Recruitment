//
//  LoadingState.swift
//  TheGoodCorner
//
//  Created by Khawla Zarrami on 16/09/2026.
//

import Foundation

enum LoadingState<Value: Decodable> {
    case idle
    case loading
    case empty
    case error(String)
    case loaded(Value)
}

extension LoadingState: Equatable where Value :Equatable {
    static func == (lhs: LoadingState<Value>, rhs: LoadingState<Value>) -> Bool {
        switch (lhs, rhs) {
        case (.idle, .idle):
            return true
        case (.loading, .loading):
            return true
        case (.empty, .empty):
            return true
        case (.error(let lhsMessage), .error(let rhsMessage)):
            return lhsMessage == rhsMessage
            
        case (.loaded(let lhsValue), .loaded(let rhsValue)):
            return lhsValue == rhsValue
            
        default:
            return false
        }
    }
}
