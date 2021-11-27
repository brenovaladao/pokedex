//
//  PokemonsFactory.swift
//  PokedexTests
//
//  Created by Breno Valadão on 27/11/21.
//

import Foundation
import Pokedex

enum PokemonsFactory {
    static private let jsonLoader = JSONLoader()
    
    static func getAPIPokemonsFromLocalJSON() -> [APIPokemon] {
        let apiPokemons = jsonLoader.decodeFromLocalJSON(objectType: [APIPokemon].self, from: "pokemons")
        return apiPokemons
    }
    
    static func getCachePokemonsFromLocalJSON(captureDate: Date) -> [CachePokemon] {
        getPokemonsFromLocalJSON().map {
            CachePokemon(pokemon: $0, captureDate: captureDate)
        }
    }
    
    static func getPokemonsFromLocalJSON() -> [Pokemon] {
        getAPIPokemonsFromLocalJSON().map(\.pokemonValue)
    }
}
