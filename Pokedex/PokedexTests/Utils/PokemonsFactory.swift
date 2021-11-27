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
    
    static func getAPIPokemonsFromLocalJSON(sorted: Bool = true) -> [APIPokemon] {
        let fileName = sorted ? "pokemons_array_sorted" : "pokemons_array_unsorted"
        let apiPokemons = jsonLoader.decodeFromLocalJSON(objectType: [APIPokemon].self, fileName: fileName)
        return apiPokemons
    }
    
    static func getCachePokemonsFromLocalJSON(sorted: Bool = true, captureDate: Date) -> [CachePokemon] {
        getPokemonsFromLocalJSON(sorted: sorted).map {
            CachePokemon(pokemon: $0, captureDate: captureDate)
        }
    }
    
    static func getPokemonsFromLocalJSON(sorted: Bool = true) -> [Pokemon] {
        getAPIPokemonsFromLocalJSON(sorted: sorted).map(\.pokemonValue)
    }
    
    static func getPokemonFromLocalJSON() -> Pokemon {
        jsonLoader.decodeFromLocalJSON(objectType: APIPokemon.self, fileName: "pokemon")
            .pokemonValue
    }
}
