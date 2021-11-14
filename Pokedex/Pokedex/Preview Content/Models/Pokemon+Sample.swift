//
//  Pokemon+Sample.swift
//  Pokedex
//
//  Created by Breno Valadão on 14/11/21.
//

import Foundation

extension Pokemon {
    static let sample: Pokemon = Pokemon(
        id: 4,
        name: "charmander",
        height: 6,
        weight: 85,
        imageURL: URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/4.png")!
    )
}
