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
                    title: "Let's find them all!",
                    buttonTitle: "Search for Pokémon") {
                        fetchRamdonPokemon()
                    }
                
            case let .loaded(pokemon):
                VStack {
                    PokemonInfoView(pokemon: pokemon)

                    HStack(alignment: .center, spacing: 8) {

                        CaptureOptionView(
                            title: "Leave",
                            backgroundColor: .blue) {
                                leavePokemon()
                            }
                        CaptureOptionView(
                            title: "Catch!",
                            backgroundColor: .red) {
                                capturePokemon()
                            }
                    }
                }
                
            case let .captured(pokemon):
                PokemonCapturedView(
                    pokemon: pokemon,
                    onTap: {
                        pokemonCapturedConfirmAction()
                    })
                
            case .failure:
                // TODO: handle error
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

    func leavePokemon() {
        searchStore.setInitialState()
    }
    
    func pokemonCapturedConfirmAction() {
        searchStore.setInitialState()
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
