//
//  APIManager.swift
//  Pokedex
//
//  Created by Breno Valadão on 14/11/21.
//

import Combine
import Foundation

protocol APIManaging {
    var decoder: JSONDecoder { get }

    func fetch(url: URL) -> AnyPublisher<Data, Error>
}

final class APIManager: APIManaging {
    
    private lazy var urlSession: URLSession = {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 30
        config.timeoutIntervalForResource = 30
        
        return URLSession(configuration: config)
    }()

    lazy var decoder: JSONDecoder = {
        let decoder = JSONDecoder()

        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .iso8601

        return decoder
    }()

    func fetch(url: URL) -> AnyPublisher<Data, Error> {
        let request = URLRequest(url: url)

        return URLSession.DataTaskPublisher(request: request, session: .shared)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
                    throw APIError.unknown
                }
                
                return data
            }
            .eraseToAnyPublisher()
    }
}
