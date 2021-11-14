//
//  FilledButtonStyle.swift
//  Pokedex
//
//  Created by Breno Valadão on 14/11/21.
//

import SwiftUI

struct FilledButtonStyle: ButtonStyle {
    let backgroundColor: Color

    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .background(backgroundColor)
            .cornerRadius(16)
            .frame(maxWidth: .infinity)
    }
}
