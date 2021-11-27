//
//  CacheManager.swift
//  Pokedex
//
//  Created by Breno Valadão on 14/11/21.
//

import Foundation

final public class CacheManager: CacheManaging {
    
    private let userDefaults: UserDefaults
    private var cachedPokemons = [CachePokemon]()
    
    private lazy var decoder = JSONDecoder()
    private lazy var encoder = JSONEncoder()

    public init(userDefaults: UserDefaults) {
        self.userDefaults = userDefaults
        cachedPokemons = (try? fetchPokemons()) ?? []
    }
    
    public func savePokemon(_ pokemon: CachePokemon) throws {
        cachedPokemons.append(pokemon)
        
        guard let data = try? encoder.encode(cachedPokemons) else {
            throw CacheError.encoding
        }
        
        userDefaults.set(data, forKey: Configuration.default.capturedPokemonsCacheKey)
        userDefaults.synchronize()
    }
    
    public func fetchPokemons() throws -> [CachePokemon] {
        guard let data = userDefaults.value(forKey: Configuration.default.capturedPokemonsCacheKey) as? Data else {
            return []
        }
        guard let decodedPokemons = try? decoder.decode([CachePokemon].self, from: data) else {
            throw CacheError.decoding
        }
        cachedPokemons = decodedPokemons
        return cachedPokemons
    }
    
    public func pokemonAlreadyCaptured(pokemonId: Int) -> Bool {
        cachedPokemons
            .map(\.id)
            .contains(pokemonId)
    }
}
