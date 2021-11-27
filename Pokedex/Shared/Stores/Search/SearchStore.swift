//
//  SearchStore.swift
//  Pokedex
//
//  Created by Breno Valadão on 14/11/21.
//

import Foundation
import Combine

final public class SearchStore: ObservableObject, SearchStoring {
    @Injected private var apiManager: APIManaging
    @Injected private var cacheManager: CacheManaging
    
    @Published public var state: State
    
    private var cancellables: [AnyCancellable]

    public init() {
        state = .initial
        cancellables = []
    }
    
    public func fetchRandomPokemon() {
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
                // This is defenitely not the best way to track reachability, but I don't
                // want to add 3rd party library right now and I was trying a solution using
                // `NWPathMonitor` but it didn't work as expected. So, right now we're
                // only displaying the correct error message based on the HTTP error status.
                if (error as NSError).code == -1020 {
                    return Just(.failure(.noInternetConnection))
                        .eraseToAnyPublisher()
                }
                return Just(.failure(.errorRetrievingRandomPokemon))
                    .eraseToAnyPublisher()
            }
            .assign(to: \.state, on: self)
            .store(in: &cancellables)
    }
    
    public func setInitialState() {
        state = .initial
    }
    
    public func captureCurrentPokemon() {
        guard
            case let .loaded(pokemon, isAlreadyCaptured) = state,
            !isAlreadyCaptured
        else {
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

public extension SearchStore {
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

public extension SearchStore {
    enum SearchError: LocalizedError {
        case errorRetrievingRandomPokemon
        case errorCapturingPokemon
        case noInternetConnection
        
        var errorDescription: String {
            switch self {
            case .errorCapturingPokemon:
                return "An error happened when capturing the pokemon."
            case .errorRetrievingRandomPokemon:
                return "An error happened when fetching the pokemon."
            case .noInternetConnection:
                return "No internet connection."
            }
        }
        
        var actionTitle: String {
            switch self {
            case .errorCapturingPokemon:
                return "OK"
            case .errorRetrievingRandomPokemon,
                 .noInternetConnection:
                return "Try again"
            }
        }
    }
}

// MARK: - Constants

private enum FileConstants {
    static let POKEMONS_IDS_RANGE = 1...1000
}
