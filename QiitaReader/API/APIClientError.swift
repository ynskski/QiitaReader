//
//  APIError.swift
//  QiitaReader
//
//  Created by YunosukeSakai on 2021/01/21.
//

import Foundation

enum APIClientError: LocalizedError {
    case unexpectedStatusCode(Int)
    case message(String, String, Int)
    case noClientIdOrSecret

    var errorDescription: String? {
        switch self {
        case let .unexpectedStatusCode(statusCode):
            return "Unexpected Status Code: \(statusCode)"
        case let .message(message, type, statusCode):
            return "Error: \(message), \(type), \(statusCode)"
        case .noClientIdOrSecret:
            return "No client_id or client_secret"
        }
    }
}
