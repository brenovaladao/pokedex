//
//  APIPokemon.swift
//  Pokedex
//
//  Created by Breno Valadão on 14/11/21.
//

import Foundation

public struct APIPokemon: Decodable {
    let id: Int
    let name: String
    let height: Int
    let weight: Int
    let sprites: Sprite
    let order: Int
    let baseExperience: Int
    let types: [APIPokemonType]
}

public extension APIPokemon {
    var pokemonValue: Pokemon {
        Pokemon(
            id: id,
            name: name,
            height: height,
            weight: weight,
            imageURL: sprites.frontDefault,
            order: order,
            baseExperience: baseExperience,
            types: types.map { PokemonType(name: $0.name) },
            captureDate: nil
        )
    }
}
