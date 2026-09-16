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
