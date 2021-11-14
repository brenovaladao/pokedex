//
//  APIError.swift
//  Pokedex
//
//  Created by Breno Valadão on 14/11/21.
//

import Foundation

enum APIError: Error, LocalizedError {
    case unknown
    case apiError(reason: String)

    var errorDescription: String? {
        switch self {
        case .unknown:
            return "Unknown error"
        case let .apiError(reason):
            return reason
        }
    }
}
