//
//  CacheManagerTests.swift
//  PokedexTests
//
//  Created by Breno Valadão on 26/11/21.
//

import XCTest
import Pokedex

class CacheManagerTests: XCTestCase {
    
    let userDefaults = UserDefaults(suiteName: "pokemon.tests.suite.name")!

    override func setUp() {
        userDefaults.clearAllKeys()
    }
    
    func test_savePokemonsThenFetchWithSuccess() throws {
        let sut = makeSUT()
        let captureDate = Date()
        let mockPokemons = makeCachePokemons(captureDate: captureDate)
        
        let initialPokemons = try sut.fetchPokemons()
        XCTAssertTrue(initialPokemons.isEmpty)
        
        try mockPokemons.forEach {
            try sut.savePokemon($0)
        }

        let pokemons = try sut.fetchPokemons()
        XCTAssert(pokemons == mockPokemons)
    }
    
    func test_fetchCachedPokemonsWithFailure() throws {
        let sut = makeSUT()
        let initialPokemons = try sut.fetchPokemons()

        XCTAssertTrue(initialPokemons.isEmpty)
        
        let invalidPokemonData = Data()
        userDefaults.set(invalidPokemonData, forKey: Configuration.default.capturedPokemonsCacheKey)

        do {
            _ = try sut.fetchPokemons()
        } catch {
            guard let cacheError = error as? CacheError else {
                XCTFail("Unexpected error")
                return
            }
            XCTAssert(cacheError == .decoding, "Expected decoding error")
        }
    }
    
    func test_checkIfPokemonWasAlreadyPersistedWithEmptyCache() throws {
        let sut = makeSUT()
        let captureDate = Date()
        let mockPokemon = makeCachePokemons(captureDate: captureDate).first!

        let initialPokemons = try sut.fetchPokemons()
        XCTAssertTrue(initialPokemons.isEmpty)

        let alreadyCaptured = sut.pokemonAlreadyCaptured(pokemonId: mockPokemon.id)
        XCTAssertFalse(alreadyCaptured, "This Pokémon has not been captured yet")
    }
    
    func test_checkIfPokemonWasAlreadyPersistedWithCache() throws {
        let sut = makeSUT()
        let captureDate = Date()
        let mockPokemons = makeCachePokemons(captureDate: captureDate)

        let initialPokemons = try sut.fetchPokemons()
        XCTAssertTrue(initialPokemons.isEmpty)

        try mockPokemons.forEach {
            try sut.savePokemon($0)
        }

        let alreadyCaptured = sut.pokemonAlreadyCaptured(pokemonId: mockPokemons.first!.id)
        XCTAssertTrue(alreadyCaptured, "This Pokemon has already been captured")
    }
    
    // MARK: - Factories
    
    func makeSUT() -> CacheManaging {
        let cacheManager = CacheManager(userDefaults: userDefaults)
        return cacheManager
    }
    
    func makeCachePokemons(captureDate: Date) -> [CachePokemon] {
        PokemonsFactory.getCachePokemonsFromLocalJSON(captureDate: captureDate)
    }
}
