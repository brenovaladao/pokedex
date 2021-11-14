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
            AsyncImage(url: pokemon.imageURL) { image in
                image.resizable()
            } placeholder: {
                Text("...")
            }
            .frame(width: 80, height: 80)
            
            Text(pokemon.displayName)
                .padding([.trailing, .leading, .bottom], 8)
                .foregroundColor(.white)
        }
        .background(.gray)
        .cornerRadius(8)
    }
}

struct PokemonItem_Previews: PreviewProvider {
    static var previews: some View {
        PokemonListItem(pokemon: Pokemon.sample)
    }
}
