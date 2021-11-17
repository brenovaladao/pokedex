//
//  BackpackView.swift
//  Pokedex
//
//  Created by Breno Valadão on 14/11/21.
//

import SwiftUI

struct BackpackView: View {
    @EnvironmentObject var backpackStore: BackpackStore
    
    private let columns = [GridItem(.adaptive(minimum: PokemonListItem.frame.width))]
    let switchTabHandler: TapHandler
    
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
                    LazyVGrid(columns: columns, spacing: 8) {
                        ForEach(pokemons) { pokemon in
                            NavigationLink(destination: PokemonDetail(pokemon: pokemon)) {
                                PokemonListItem(pokemon: pokemon)
                            }
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
        .navigationTitle("Backpack")
        .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: - Actions

private extension BackpackView {
    func navigateToSearchPokemonsView() {
        switchTabHandler()
    }
}

struct BackpackView_Previews: PreviewProvider {
    static var previews: some View {
        BackpackView(switchTabHandler: {})
    }
}
