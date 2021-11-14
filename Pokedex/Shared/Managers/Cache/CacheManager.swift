//
//  CacheManager.swift
//  Pokedex
//
//  Created by Breno Valadão on 14/11/21.
//

import Foundation

final class CacheManager: CacheManaging {
    
    private let userDefaults: UserDefaults
    private var cachedPokemons = [CachePokemon]()
    
    private lazy var decoder = JSONDecoder()
    private lazy var encoder = JSONEncoder()

    init(userDefaults: UserDefaults) {
        self.userDefaults = userDefaults
    }
    
    func savePokemon(_ pokemon: CachePokemon) throws {
        cachedPokemons.append(pokemon)
        
        guard let data = try? encoder.encode(cachedPokemons) else {
            throw CacheError.encoding
        }
        
        userDefaults.set(data, forKey: Configuration.default.capturedPokemonsCacheKey)
        userDefaults.synchronize()
    }
    
    func fetchPokemons() throws -> [CachePokemon] {
        guard let data = userDefaults.value(forKey: Configuration.default.capturedPokemonsCacheKey) as? Data else {
            return []
        }
        guard let decodedPokemons = try? decoder.decode([CachePokemon].self, from: data) else {
            throw CacheError.decoding
        }
        cachedPokemons = decodedPokemons
        return cachedPokemons
    }
    
    func pokemonAlreadyCaptured(pokemonId: Int) -> Bool {
        cachedPokemons
            .map(\.id)
            .contains(pokemonId)
    }
}
