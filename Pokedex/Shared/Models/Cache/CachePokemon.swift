//
//  CachePokemon.swift
//  Pokedex
//
//  Created by Breno Valadão on 14/11/21.
//

import Foundation

struct CachePokemon: Codable {
    struct CachePokemonType: Codable {
        let name: String
    }
    
    let id: Int
    let name: String
    let height: Int
    let weight: Int
    let imageURL: URL
    let order: Int
    let types: [CachePokemonType]
    let captureDate: Date
    
    init(pokemon: Pokemon, captureDate: Date) {
        id = pokemon.id
        name = pokemon.name
        height = pokemon.height
        weight = pokemon.weight
        imageURL = pokemon.imageURL
        order = pokemon.order
        types = pokemon.types.map { CachePokemonType(name: $0.name) }
        self.captureDate = captureDate
    }
    
    var pokemonValue: Pokemon {
        Pokemon(
            id: id,
            name: name,
            height: height,
            weight: weight,
            imageURL: imageURL,
            order: order,
            types: types.map { PokemonType(name: $0.name) },
            captureDate: captureDate
        )
    }
}
