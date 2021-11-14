//
//  Pokemon.swift
//  Pokedex
//
//  Created by Breno Valadão on 14/11/21.
//

import Foundation

struct Pokemon: Identifiable {
    let id: Int
    let name: String
    let height: Int
    let weight: Int
    let imageURL: URL
    
    var displayName: String {
        name.capitalized
    }
    
    // The height of this Pokémon in centimeter.
    var displayHeightInCentimeters: String {
        "\(height * 10) cm"
    }
    
    // The weight of this Pokémon in kilos.
    var displayWeightInKilos: String {
        "\(weight / 10) kg"
    }
}
