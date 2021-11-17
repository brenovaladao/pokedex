//
//  PokemonImage.swift
//  Pokedex
//
//  Created by Breno Valadão on 17/11/21.
//

import SwiftUI

struct PokemonImage: View {
    let url: URL
    let frameRatio: CGFloat
    
    init(url: URL, frameRatio: CGFloat = 130) {
        self.url = url
        self.frameRatio = frameRatio
    }
    
    var body: some View {
        AsyncImage(url: url) { image in
            image.resizable()
        } placeholder: {
            Text("...")
                .foregroundColor(.text)
        }
        .frame(width: frameRatio, height: frameRatio)
    }
}

struct PokemonImage_Previews: PreviewProvider {
    static var previews: some View {
        PokemonImage(url: Pokemon.sample.imageURL)
    }
}
