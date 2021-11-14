//
//  EmptyView.swift
//  Pokedex
//
//  Created by Breno Valadão on 14/11/21.
//

import SwiftUI

struct EmptyView: View {    
    let title: String
    let buttonTitle: String
    var onTap: TapHandler
    
    var body: some View {
        VStack(spacing: 24) {
            Text(title)
                .font(.title2)
            Button(action: onTap) {
                Text(buttonTitle)
                    .padding()
                    .foregroundColor(.white)
                    .font(.buttonTitle)
            }
            .buttonStyle(
                FilledButtonStyle(backgroundColor: .blue)
            )
        }
    }
}

struct EmptyView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyView(
            title: "Seach Pokémons",
            buttonTitle: "Search",
            onTap: {}
        )
    }
}
