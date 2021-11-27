//
//  CacheManaging.swift
//  Pokedex
//
//  Created by Breno Valadão on 14/11/21.
//

import Foundation

public protocol CacheManaging: AnyObject {
    
    init(userDefaults: UserDefaults)
    
    func savePokemon(_ pokemon: CachePokemon) throws
    
    func fetchPokemons() throws -> [CachePokemon]
    
    func pokemonAlreadyCaptured(pokemonId: Int) -> Bool
}
