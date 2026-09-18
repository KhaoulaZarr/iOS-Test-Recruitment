//
//  StaticJsonMapper.swift
//  TheGoodCorner
//
//  Created by Khawla Zarrami on 18/09/2026.
//

import Foundation

struct StaticJsonMapper {
    
    static func decode<T: Decodable>(file: String, type: T.Type) throws -> T {
        guard !file.isEmpty, let path = Bundle.main.path(forResource: file, ofType: "json"),
              let data = FileManager.default.contents(atPath: path) else {
            throw MappingError.failedToGetContents
        }
        let decoder = JSONDecoder()
        return  try decoder.decode(T.self, from: data)
    }
}

extension StaticJsonMapper {
    enum MappingError: Error {
        case failedToGetContents
    }
}
