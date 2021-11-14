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
    @Injected private var cacheManager: CacheManaging
    
    @Published var state: State = .initial
    
    private var cancellables = [AnyCancellable]()

    func fetchRandomPokemon() {
        let pokemonId = generateRandomPokemonId
        let searchPokemonUrl = Configuration.default.apiBaseURL.appendingPathComponent("pokemon/\(pokemonId)")
                
        apiManager.fetch(url: searchPokemonUrl)
            .decode(type: APIPokemon.self, decoder: apiManager.decoder)
            .receive(on: DispatchQueue.main)
            .map { receivedPokemon -> State in
                .loaded(receivedPokemon.pokemonValue)
            }
            .catch { error -> AnyPublisher<State, Never> in
                Just(.failure(SearchError.errorRetrievingRandomPokemon))
                    .eraseToAnyPublisher()
            }
            .assign(to: \.state, on: self)
            .store(in: &cancellables)
    }
    
    func captureCurrentPokemon() {
        guard case let .loaded(pokemon) = state else {
            return
        }
        
        let cachePokemon = CachePokemon(pokemon: pokemon)
        
        do {
            try cacheManager.savePokemon(cachePokemon)
        } catch {
            state = .failure(SearchError.errorCapturingPokemon)
        }
    }
}

// MARK: - State
extension SearchStore {
    enum State {
        case initial
        case loaded(Pokemon)
        case failure(SearchError)
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
        case errorCapturingPokemon
    }
}

// MARK: - Constants
private enum FileConstants {
    static let POKEMONS_IDS_RANGE = 1...1000
}
