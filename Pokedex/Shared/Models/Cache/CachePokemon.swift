//
//  CachePokemon.swift
//  Pokedex
//
//  Created by Breno Valadão on 14/11/21.
//

import Foundation

struct CachePokemon: Codable {
    let id: Int
    let name: String
    let height: Int
    let weight: Int
    let imageURL: URL
    
    init(pokemon: Pokemon) {
        id = pokemon.id
        name = pokemon.name
        height = pokemon.height
        weight = pokemon.weight
        imageURL = pokemon.imageURL
    }
    
    var pokemonValue: Pokemon {
        Pokemon(
            id: id,
            name: name,
            height: height,
            weight: weight,
            imageURL: imageURL
        )
    }
}
