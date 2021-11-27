//
//  CachePokemon.swift
//  Pokedex
//
//  Created by Breno Valadão on 14/11/21.
//

import Foundation

public struct CachePokemon: Codable, Equatable {
    public struct CachePokemonType: Codable, Equatable {
        let name: String
    }
    
    public let id: Int
    public let name: String
    public let height: Int
    public let weight: Int
    public let imageURL: URL
    public let order: Int
    public let baseExperience: Int
    public let types: [CachePokemonType]
    public let captureDate: Date
    
    public init(pokemon: Pokemon, captureDate: Date) {
        id = pokemon.id
        name = pokemon.name
        height = pokemon.height
        weight = pokemon.weight
        imageURL = pokemon.imageURL
        order = pokemon.order
        baseExperience = pokemon.baseExperience
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
            baseExperience: baseExperience,
            types: types.map { PokemonType(name: $0.name) },
            captureDate: captureDate
        )
    }
}
