//
//  CacheManaging.swift
//  Pokedex
//
//  Created by Breno Valadão on 14/11/21.
//

import Foundation

protocol CacheManaging: AnyObject {
    func savePokemon(_ pokemon: CachePokemon) throws
    
    func fetchPokemons() throws -> [CachePokemon]
    
    func pokemonAlreadyCaptured(pokemonId: Int) -> Bool
}
