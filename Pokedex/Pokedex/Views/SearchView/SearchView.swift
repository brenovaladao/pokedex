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
        Text("Search")
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
