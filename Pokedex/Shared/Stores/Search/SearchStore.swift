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
        guard !state.isLoading else {
            return
        }
        
        state = .loading
        
        let pokemonId = generateRandomPokemonId
        let searchPokemonUrl = Configuration.default.apiBaseURL.appendingPathComponent("pokemon/\(pokemonId)")
                
        apiManager.fetch(url: searchPokemonUrl)
            .decode(type: APIPokemon.self, decoder: apiManager.decoder)
            .receive(on: DispatchQueue.main)
            .compactMap { [weak self] receivedPokemon -> State? in
                guard let self = self else {
                    return nil
                }
                return .loaded(
                    receivedPokemon.pokemonValue,
                    isAlreadyCaptured: self.cacheManager.pokemonAlreadyCaptured(pokemonId: receivedPokemon.id)
                )
            }
            .catch { error -> AnyPublisher<State, Never> in
                Just(.failure(.errorRetrievingRandomPokemon))
                    .eraseToAnyPublisher()
            }
            .assign(to: \.state, on: self)
            .store(in: &cancellables)
    }
    
    func setInitialState() {
        state = .initial
    }
    
    func captureCurrentPokemon() {
        guard case let .loaded(pokemon, _) = state else {
            return
        }
        
        state = .captured(pokemon)
        
        let cachePokemon = CachePokemon(pokemon: pokemon, captureDate: Date())
        
        do {
            try cacheManager.savePokemon(cachePokemon)
        } catch {
            state = .failure(.errorCapturingPokemon)
        }
    }
}

// MARK: - State
extension SearchStore {
    enum State {
        case initial
        case loading
        case loaded(Pokemon, isAlreadyCaptured: Bool)
        case captured(Pokemon)
        case failure(SearchError)
        
        var isLoading: Bool {
            if case .loading = self {
                return true
            }
            return false
        }
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
