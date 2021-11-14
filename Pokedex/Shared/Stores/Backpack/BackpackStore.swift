//
//  BackpackStore.swift
//  Pokedex
//
//  Created by Breno Valadão on 14/11/21.
//

import Foundation
import Combine

final class BackpackStore: ObservableObject, BackpackStoring {
    @Injected private var cacheManager: CacheManaging
    @Published var state: State = .empty

    func fetchCapturePokemonsList() {
        do {
            let capturedPokemons = try cacheManager.fetchPokemons()
                .sorted(by: { $0.id < $1.id })
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
extension BackpackStore {
    enum State {
        case empty
        case loaded([Pokemon])
        case failure(BackpackError)
    }
}

// MARK: - SearchError

extension BackpackStore {
    enum BackpackError: Error {
        case errorFetchingCapturedPokemons
    }
}
