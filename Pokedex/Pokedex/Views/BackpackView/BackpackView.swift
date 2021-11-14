//
//  BackpackView.swift
//  Pokedex
//
//  Created by Breno Valadão on 14/11/21.
//

import SwiftUI

struct BackpackView: View {
    @EnvironmentObject var backpackStore: BackpackStore

    private let columns = [GridItem(.adaptive(minimum: 80))]
    
    var body: some View {
        Group {
            switch backpackStore.state {
            case .empty:
                EmptyView(
                    title: "Your backpack is empty!",
                    buttonTitle: "Search Pokémons") {
                        navigateToSearchPokemonsView()
                    }
            case let .loaded(pokemons):
                ScrollView {
                    LazyVGrid(
                        columns: columns,
                        spacing: 8) {
                            ForEach(pokemons) { pokemon in
                                PokemonListItem(pokemon: pokemon)
                            }
                        }
                }
            case .failure:
                // TODO: handle error
                EmptyView(
                    title: "Error",
                    buttonTitle: "Try again") {
                        backpackStore.fetchCapturePokemonsList()
                    }
            }
        }
        .onAppear {
            backpackStore.fetchCapturePokemonsList()
        }
    }
}

// MARK: - Actions

extension BackpackView {
    func navigateToSearchPokemonsView() {
        
    }
}

struct BackpackView_Previews: PreviewProvider {
    static var previews: some View {
        BackpackView()
    }
}
