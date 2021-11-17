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
        VStack(alignment: .leading, spacing: 8) {
            PokemonImage(url: pokemon.imageURL)
            Text("Name: \(pokemon.displayName)")
            Text("Height: \(pokemon.displayHeightInCentimeters)")
            Text("Weight: \(pokemon.displayWeightInKilos)")
            Text("Types: \(pokemon.displayTypes)")
            Text("Captured on: \(pokemon.diplayCaptureDate)")
        }
    }
}

struct PokemonDetail_Previews: PreviewProvider {
    static var previews: some View {
        PokemonDetail(pokemon: .sample)
    }
}
