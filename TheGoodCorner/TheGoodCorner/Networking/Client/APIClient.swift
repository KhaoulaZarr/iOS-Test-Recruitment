//
//  APIClient.swift
//  TheGoodCorner
//
//  Created by Khawla Zarrami on 16/09/2026.
//

import Foundation

struct APIClient {
    let baseURL: URL
    var session: URLSession = .shared
    var decoder: JSONDecoder = JSONDecoder()
    
     func execute<Response>(_ requestModel: APIRequest<Response>) async throws -> Response {
         do {
             let request = try requestModel.makeURLRequest(baseURL: baseURL)
             let (data, response) = try await session.data(for: request)
             guard let httpResponse = response as? HTTPURLResponse else {
                 throw NetworkError.invalidResponse
             }
             guard 200..<300 ~= httpResponse.statusCode else {
                 throw NetworkError.httpStatus(code: httpResponse.statusCode)
             }
             return try decoder.decode(Response.self, from: data)
         } catch {
             let mapped = NetworkErrorMapper.map(error)
             throw mapped
         }
    }
}
