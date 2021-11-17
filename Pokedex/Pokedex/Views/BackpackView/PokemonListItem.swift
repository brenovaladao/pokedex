//
//  PokemonListItem.swift
//  Pokedex
//
//  Created by Breno Valadão on 14/11/21.
//

import SwiftUI

struct PokemonListItem: View {
    let pokemon: Pokemon

    var body: some View {
        VStack(spacing: 0) {
            
            PokemonImage(
                url: pokemon.imageURL,
                frameRatio: 80
            )
            Text(pokemon.displayName)
                .padding([.trailing, .leading, .bottom], 8)
                .foregroundColor(.text)
        }
        .background(Color.itemBackground)
        .cornerRadius(8)
    }
}

struct PokemonItem_Previews: PreviewProvider {
    static var previews: some View {
        PokemonListItem(pokemon: Pokemon.sample)
    }
}
