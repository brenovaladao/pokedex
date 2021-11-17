//
//  PokedexApp.swift
//  Pokedex
//
//  Created by Breno Valadão on 14/11/21.
//

import SwiftUI

@main
struct PokedexApp: App {
    
    private let container = DIContainer()
    
    @StateObject private var searchStore = SearchStore()
    @StateObject private var backpackStore = BackpackStore()

    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(searchStore)
                .environmentObject(backpackStore)
        }
    }
}
