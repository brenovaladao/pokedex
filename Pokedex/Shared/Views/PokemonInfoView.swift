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
                Text("Name: \(pokemon.displayName)")
                Text("Height: \(pokemon.displayHeightInCentimeters)")
                Text("Weight: \(pokemon.displayWeightInKilos)")
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
