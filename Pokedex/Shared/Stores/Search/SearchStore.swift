//
//  SearchStore.swift
//  Pokedex
//
//  Created by Breno Valadão on 14/11/21.
//

import Foundation
import Combine

final class SearchStore: ObservableObject, SearchStoring {
    @Injected private var apiManager: APIManaging
    @Published var state: State = State(loaded: .empty)

    private var cancellables = [AnyCancellable]()

    func fetchRandomPokemon() {
        let pokemonId = generateRandomPokemonId
        let searchPokemonUrl = Configuration.default.apiBaseURL.appendingPathComponent("pokemon/\(pokemonId)")
        
        apiManager.fetch(url: searchPokemonUrl)
            .decode(type: APIPokemon.self, decoder: apiManager.decoder)
            .receive(on: DispatchQueue.main)
            .map { receivedPokemon -> State in
                State(loaded: .pokemon(receivedPokemon.pokemonValue))
            }
            .catch { _ -> AnyPublisher<State, Never> in
                Just(State(loaded: .empty, error: SearchError.errorRetrievingRandomPokemon))
                    .eraseToAnyPublisher()
            }
            .assign(to: \.state, on: self)
            .store(in: &cancellables)
    }
}

// MARK: - Helpers

private extension SearchStore {
    var generateRandomPokemonId: Int {
        Int.random(in: FileConstants.POKEMONS_IDS_RANGE)
    }
}

// MARK: - SearchError

extension SearchStore {
    enum SearchError: Error {
        case errorRetrievingRandomPokemon
    }
}

// MARK: - Constants
private enum FileConstants {
    static let POKEMONS_IDS_RANGE = 1...1000
}
