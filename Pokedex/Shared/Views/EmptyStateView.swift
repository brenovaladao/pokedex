//
//  EmptyStateView.swift
//  Pokedex
//
//  Created by Breno Valadão on 14/11/21.
//

import SwiftUI

struct EmptyStateView: View {    
    let title: String
    let buttonTitle: String
    var onTap: TapHandler
    
    var body: some View {
        VStack(spacing: 24) {
            Text(title)
                .multilineTextAlignment(.center)
                .font(.title2)
            Button(action: onTap) {
                Text(buttonTitle)
                    .padding()
                    .foregroundColor(.buttonText)
                    .font(.buttonTitle)
            }
            .buttonStyle(
                FilledButtonStyle(backgroundColor: .mainButtonBackground)
            )
        }
    }
}

struct EmptyView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyStateView(
            title: "Search Pokémons",
            buttonTitle: "Search",
            onTap: {}
        )
        EmptyStateView(
            title: "Search Pokémons",
            buttonTitle: "Search",
            onTap: {}
        )
        .preferredColorScheme(.dark)
    }
}
