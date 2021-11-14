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
        Group {
            switch searchStore.state {
            case .initial:
                EmptyView(
                    title: "Search for a Pokémon!",
                    buttonTitle: "Search") {
                        fetchRamdonPokemon()
                    }
                
            case let .loaded(pokemon):
                VStack {
                    PokemonInfoView(pokemon: pokemon)

                    HStack(alignment: .center, spacing: 8) {

                        CaptureOptionItemView(
                            title: "Leave",
                            backgroundColor: .blue) {
                                letPokemonLeave()
                            }
                        CaptureOptionItemView(
                            title: "Catch!",
                            backgroundColor: .red) {
                                capturePokemon()
                            }
                    }
                }
                
            case .failure:
                EmptyView(
                    title: "No Pokémon found",
                    buttonTitle: "Try again") {
                        fetchRamdonPokemon()
                    }
            }
        }
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
            .environmentObject(SearchStore())
    }
}
