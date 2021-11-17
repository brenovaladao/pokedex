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
                InfoLabel(title: "Name", info:pokemon.displayName)
                InfoLabel(title: "Captured on", info:pokemon.diplayCaptureDate)
                InfoLabel(title: "Weight", info:pokemon.displayWeightInKilos)
                InfoLabel(title: "Height", info:pokemon.displayHeightInCentimeters)
                InfoLabel(title: "Base experience", info:pokemon.displayBaseExperiece)
                InfoLabel(title: "Types", info:pokemon.displayTypes)
            }
            .padding()
        }
    }
}

struct PokemonDetail_Previews: PreviewProvider {
    static var previews: some View {
        PokemonDetail(pokemon: .sample)
    }
}
