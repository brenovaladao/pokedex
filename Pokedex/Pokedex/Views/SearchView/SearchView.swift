//
//  SearchView.swift
//  Pokedex
//
//  Created by Breno Valadão on 14/11/21.
//

import SwiftUI

struct SearchView: View {
    @EnvironmentObject var searchStore: SearchStore

    var body: some View {
        PokemonInfoView(pokemon: Pokemon.sample)
//        Group {
//            switch searchStore.state.loaded {
//            case .empty:
//                Text("Empty")
//            case let pokemon(pokemon):
//                PokemonInfoView(pokemon: pokemon)
//            }
//        }
    }
}

// MARK: - Actions

extension SearchView {
    func fetchRamdonPokemon() {
        searchStore.fetchRandomPokemon()
    }

    func letPokemonLeave() {
        searchStore.fetchRandomPokemon()
    }

    func capturePokemon() {
        searchStore.captureCurrentPokemon()
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
