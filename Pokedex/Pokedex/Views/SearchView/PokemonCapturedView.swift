//
//  PokemonCapturedView.swift
//  Pokedex
//
//  Created by Breno Valadão on 14/11/21.
//

import SwiftUI

struct PokemonCapturedView: View {
    let pokemon: Pokemon
    let onTap: TapHandler
    
    var body: some View {
        VStack {
            Text("\(pokemon.displayName) captured!")
                .font(.title)
            
            AsyncImage(url: pokemon.imageURL) { image in
                image.resizable()
            } placeholder: {
                Text("...")
            }
            .frame(width: 130, height: 130)
            .padding()
            
            Button(action: onTap) {
                Text("Search more Pokémons")
                    .padding([.top, .bottom], 12)
                    .padding([.leading, .trailing], 22)
                    .foregroundColor(.white)
                    .font(.buttonTitle)
            }
            .buttonStyle(
                FilledButtonStyle(backgroundColor: .blue)
            )
        }
    }
}

struct CatchingPokemonView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonCapturedView(pokemon: Pokemon.sample, onTap: {})
    }
}
