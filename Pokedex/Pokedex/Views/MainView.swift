//
//  MainView.swift
//  Pokedex
//
//  Created by Breno Valadão on 14/11/21.
//

import SwiftUI

struct MainView: View {
    @State private var selection: Tab = .search
    
    var body: some View {
        TabView(selection: $selection) {
            SearchView()
            .tabItem {
                Image(systemName: "magnifyingglass")
                Text("Search")
            }
            .tag(Tab.search)
            
            NavigationView {
                BackpackView(switchTabHandler: switchToSearchTab)
                    .navigationTitle("Backpack")
                    .navigationBarTitleDisplayMode(.inline)
            }
            .tabItem {
                Image(systemName: "bag")
                Text("Backpack")
            }
            .tag(Tab.backpack)
        }
    }
}

// MARK: - Actions

private extension MainView {
    func switchToSearchTab() {
        selection = .search
    }
}

// MARK: - Tabs
private extension MainView {
    enum Tab: Int {
        case search
        case backpack
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
