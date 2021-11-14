//
//  APIPokemon.swift
//  Pokedex
//
//  Created by Breno Valadão on 14/11/21.
//

import Foundation

struct APIPokemon: Decodable {
    let id: String
    let name: String
    let height: Int
    let weight: Int
    let sprites: [Sprite]
}
