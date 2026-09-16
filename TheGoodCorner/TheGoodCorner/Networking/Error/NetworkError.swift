//
//  NetworkError.swift
//  TheGoodCorner
//
//  Created by Khawla Zarrami on 16/09/2026.
//
import Foundation

enum NetworkError: Error, LocalizedError {
    case transport(URLError)
    case invalidResponse
    case httpStatus(code: Int)
    case decodingFailed(Error)
    case unknown(Error)
    
    var statusCode: Int? {
        guard case  .httpStatus(let code) = self else { return nil }
        return code
    }
    
    var userMessage: String {
        switch self {

        case .transport(let uRLError):
            switch uRLError.code {
            case .notConnectedToInternet:
                return "No internet connection. Check your network and try again."
            case .timedOut:
                return "The request time out. please try again."
            default:
                return "A network error occured. Please try again."
            }
        case .invalidResponse:
            return "The server returned an invalid response."
        case .httpStatus(code: let code):
            switch code {
            case 401:
                return "You are not autorized. Please sign in again."
            case 403:
                return "You do not have permission to perform this action"
            case 404:
                return "The requested source could not be found"
            case 409:
                return "The action conflicts with existing data."
            case 429:
                return "Too many requests. please wait a moment and try again."
            case 500...599:
                return "The server is having trouble right now. Please try again later."
            default:
                return "Something Went wrong. please try again."
            }
        case .decodingFailed:
            return "We received data in an unexpected format."
        case .unknown:
            return "Something Went wrong. please try again."
        }
    }
    
    var debugMessage:String {
        switch self {
        case .transport(let urlError):
            return "Transport error: \(urlError.code.rawValue) \(urlError.localizedDescription)"
        case .invalidResponse:
            return "Invalid non-HTTP response"
        case .httpStatus(let code):
            return "HTTP \(code)"
        case .decodingFailed(let error):
            return "Decoding Failed \(error)"
        case .unknown(let error):
            return "Uknown error \(error.localizedDescription)"
        }
    }
    
    var errorDescription: String? { userMessage }
}

enum NetworkErrorMapper {
    
    static func map(_ error: Error) -> NetworkError {
        if let networkError = error as? NetworkError {
            return networkError
        }
        
        if let urlError = error as? URLError {
            return .transport(urlError)
        }
        
        return .unknown(error)
    }
    
    static func httpStatus(code: Int) -> NetworkError {
         .httpStatus(code: code)
    }
    
    static func decodingFailure(_ error: Error) -> NetworkError {
        .decodingFailed(error)
    }
}
