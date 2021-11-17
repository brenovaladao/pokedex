//
//  PokemonDetail.swift
//  Pokedex
//
//  Created by Breno Valadão on 17/11/21.
//

import SwiftUI

struct PokemonDetail: View {
    
    let pokemon: Pokemon
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 8) {
                PokemonImage(url: pokemon.imageURL)
                Text("Name: \(pokemon.displayName)")
                Text("Captured on: \(pokemon.diplayCaptureDate)")
                Text("Weight: \(pokemon.displayWeightInKilos)")
                Text("Height: \(pokemon.displayHeightInCentimeters)")
                Text("Base experience: \(pokemon.baseExperience)")
                Text("Types: \(pokemon.displayTypes)")
            }
        }
    }
}

struct PokemonDetail_Previews: PreviewProvider {
    static var previews: some View {
        PokemonDetail(pokemon: .sample)
    }
}
