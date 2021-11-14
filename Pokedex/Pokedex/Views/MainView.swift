//
//  MainView.swift
//  Pokedex
//
//  Created by Breno Valadão on 14/11/21.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            SearchView()
            .tabItem {
                Image(systemName: "magnifyingglass")
                Text("Search")
            }
            NavigationView {
            }
            .tabItem {
                Image(systemName: "bag")
                Text("Backpack")
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
