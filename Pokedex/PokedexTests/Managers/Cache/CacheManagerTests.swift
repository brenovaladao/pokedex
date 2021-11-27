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

    override func setUpWithError() throws {
        userDefaults.clearAllKeys()
    }
    
    func testSavePokemonWithSuccess() {
        let sut = makeSUT()
        let captureDate = Date()
        let cachePokemon = makeCachePokemon(captureDate: captureDate)
        
        do {
            let initialPokemons = try sut.fetchPokemons()
            XCTAssertTrue(initialPokemons.isEmpty)
        } catch {
            XCTFail("Can't load cached pokemons \(error)")
        }
        
        do {
            try sut.savePokemon(cachePokemon)
        } catch {
            XCTFail("Can't save pokemon \(error)")
        }

        do {
            let pokemons = try sut.fetchPokemons()
            XCTAssert(pokemons == [cachePokemon])
        } catch {
            XCTFail("Error fetching pokemons \(error)")
        }
    }
    
    // MARK: - Factories
    
    func makeSUT() -> CacheManaging {
        let cacheManager = CacheManager(userDefaults: userDefaults)
        return cacheManager
    }
    
    func makeCachePokemon(captureDate: Date) -> CachePokemon {
        PokemonsFactory.getCachePokemonsFromLocalJSON(captureDate: captureDate).first!
    }
}
