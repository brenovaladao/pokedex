//
//  APIManagerMock.swift
//  PokedexTests
//
//  Created by Breno Valadão on 27/11/21.
//

import Combine
import Foundation
import Pokedex

final class APIManagerMock: APIManaging {
    
    private let shouldFail: Bool
    
    private let jsonLoader = JSONLoader()
    
    init(shouldFail: Bool) {
        self.shouldFail = shouldFail
    }
    
    lazy var decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .iso8601
        
        return decoder
    }()
    
    func fetch(url: URL) -> AnyPublisher<Data, Error> {
        guard !shouldFail else {
            return Fail(error: APIError.unknown)
                .eraseToAnyPublisher()
        }
        
        return Just(jsonLoader.loadDataFromLocalJSON(fileName: "pokemon"))
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}
