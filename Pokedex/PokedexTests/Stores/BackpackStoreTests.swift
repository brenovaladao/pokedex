//
//  BackpackStoreTests.swift
//  PokedexTests
//
//  Created by Breno Valadão on 27/11/21.
//

import XCTest
import Pokedex
import Combine

class BackpackStoreTests: XCTestCase {
    let userDefaults = UserDefaults(suiteName: "pokemon.tests.suite.name")!
    let cancellables = [AnyCancellable]()
    let jsonLoader = JSONLoader()
    var cacheManager: CacheManager!
    
    override func setUp() {
        cacheManager = CacheManager(userDefaults: userDefaults)
        userDefaults.clearAllKeys()
    }
    
    func test_backpackStoreInitialState() {
        let sut = makeSUT()
        
        XCTAssertTrue(sut.state == .empty)
    }
    
    func test_backpackStoreFetchPokemonsWithEmptyCache() {
        let sut = makeSUT()

        sut.fetchCapturePokemonsList()
        
        XCTAssertTrue(sut.state == .empty)
    }
    
    func test_backpackStoreFetchPokemonsWithSuccess() {
        let sut = makeSUT()
        let cachedPokemons = storeMockPokemonsInLocalCache()
        let sortedCachedPokemons = cachedPokemons.sorted(by: { $0.order < $1.order })
        
        sut.fetchCapturePokemonsList()
        
        XCTAssertTrue(sut.state == .loaded(sortedCachedPokemons))
        
        if case let .loaded(pokemons) = sut.state {
            XCTAssertTrue(pokemons[0].order < pokemons[1].order, "loaded pokemons are sorted correctly")
        }
    }
    
    func test_backpackStoreFetchPokemonsWithFailure() {
        let sut = makeSUT()
        storeInvalidDataInLocalCache()
        
        sut.fetchCapturePokemonsList()
        
        XCTAssertTrue(sut.state == .failure(.errorFetchingCapturedPokemons))
    }
    
    // MARK: - Factories
    
    func makeSUT() -> BackpackStore {
        registerMockManagers()
        let backpackStore = BackpackStore()
        return backpackStore
    }
    
    func registerMockManagers() {
        DIContainer.shared.register(CacheManaging.self, cached: true) {
            CacheManager(userDefaults: self.userDefaults)
        }
    }
    
    func storeMockPokemonsInLocalCache() -> [Pokemon] {
        let cachedPokemons = PokemonsFactory.getCachePokemonsFromLocalJSON(sorted: false, captureDate: Date())
        cachedPokemons.forEach {
            try? cacheManager.savePokemon($0)
        }
        return cachedPokemons.map(\.pokemonValue)
    }
    
    func storeInvalidDataInLocalCache() {
        let invalidPokemonData = Data()
        userDefaults.set(invalidPokemonData, forKey: Configuration.default.capturedPokemonsCacheKey)
    }
}

extension BackpackStore.State: Equatable {
    public static func == (lhs: BackpackStore.State, rhs: BackpackStore.State) -> Bool {
        switch (lhs, rhs) {
        case (.empty, .empty):
            return true
        
        case (let .loaded(lhsPokemon), let .loaded(rhsPokemon)):
            return lhsPokemon == rhsPokemon
        
        case (let .failure(lhsError), let .failure(rhsError)):
            return lhsError == rhsError
            
        default:
            return false
        }
    }
}
