//
//  Pokemon.swift
//  Pokedex
//
//  Created by Breno Valadão on 14/11/21.
//

import Foundation

public struct Pokemon: Identifiable, Equatable {
    public let id: Int
    public let name: String
    public let height: Int
    public let weight: Int
    public let imageURL: URL
    public let order: Int
    public let baseExperience: Int
    public let types: [PokemonType]
    public let captureDate: Date?
    
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
    
    var displayBaseExperiece: String {
        "\(baseExperience) xp"
    }
}
