//
//  PokemonInfoView.swift
//  Pokedex
//
//  Created by Breno Valadão on 14/11/21.
//

import SwiftUI

struct PokemonInfoView: View {
    let pokemon: Pokemon
    
    var body: some View {
        HStack {
            Spacer()
            
            PokemonImage(url: pokemon.imageURL)
            
            VStack(alignment: .leading) {
                InfoLabel(title: "Name", info: pokemon.displayName)
                InfoLabel(title: "Weight", info: pokemon.displayWeightInKilos)
                InfoLabel(title: "Height", info: pokemon.displayHeightInCentimeters)
            }
            
            Spacer()
        }
        .padding(8)
    }
}

struct PokemonInfoView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonInfoView(pokemon: Pokemon.sample)
    }
}
