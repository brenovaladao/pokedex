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
        Text(pokemon.name)
    }
}

struct PokemonDetail_Previews: PreviewProvider {
    static var previews: some View {
        PokemonDetail(pokemon: .sample)
    }
}
