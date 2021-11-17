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
    let order: Int
    let types: [PokemonType]
    let captureDate: Date?
    
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
    
    var displayTypes: String {
        types.map { $0.name.capitalized }.joined(separator: ", ")
    }
    
    var diplayCaptureDate: String {
        guard let captureDate = captureDate else {
            return "--"
        }
        return DateFormatter.mediumDateTimeFormatter.string(from: captureDate)
    }
}
