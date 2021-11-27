//
//  BackpackStore.swift
//  Pokedex
//
//  Created by Breno Valadão on 14/11/21.
//

import Foundation
import Combine

final public class BackpackStore: ObservableObject, BackpackStoring {
    @Injected private var cacheManager: CacheManaging
    @Published public var state: State

    public init() {
        self.state = .empty
    }
    
    public func fetchCapturePokemonsList() {
        do {
            let capturedPokemons = try cacheManager.fetchPokemons()
                .sorted(by: { $0.order < $1.order })
            if capturedPokemons.isEmpty {
                state = .empty
            } else {
                state = .loaded(capturedPokemons.map(\.pokemonValue))
            }
        } catch {
            state = .failure(.errorFetchingCapturedPokemons)
        }
    }
}

// MARK: - State

public extension BackpackStore {
    enum State {
        case empty
        case loaded([Pokemon])
        case failure(BackpackError)
    }
}

// MARK: - SearchError

public extension BackpackStore {
    enum BackpackError: Error {
        case errorFetchingCapturedPokemons
    
        var errorDescription: String {
            switch self {
            case .errorFetchingCapturedPokemons:
                return "An error happened while fetching captured pokémons."
            }
        }

        var actionTitle: String {
            switch self {
            case .errorFetchingCapturedPokemons:
                return "Try again"
            }
        }
    }
}
