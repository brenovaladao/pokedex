//
//  PokemonListItem.swift
//  Pokedex
//
//  Created by Breno Valadão on 14/11/21.
//

import SwiftUI

struct PokemonListItem: View {
    let pokemon: Pokemon
    static let frame = CGSize(width: 90, height: 120)
    
    var body: some View {
        VStack(spacing: 0) {
            PokemonImage(
                url: pokemon.imageURL,
                frameRatio: 80
            )
            Text(pokemon.displayName)
                .padding([.trailing, .leading, .bottom], 8)
                .foregroundColor(.text)
                .lineLimit(1)
                .minimumScaleFactor(0.8)
        }
        .background(Color.itemBackground)
        .cornerRadius(8)
        .frame(width: Self.frame.width, height: Self.frame.height)
    }
}

struct PokemonItem_Previews: PreviewProvider {
    static var previews: some View {
        PokemonListItem(pokemon: Pokemon.sample)
    }
}
