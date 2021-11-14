//
//  CaptureOptionItemView.swift
//  Pokedex
//
//  Created by Breno Valadão on 14/11/21.
//

import SwiftUI

struct CaptureOptionItemView: View {
    let title: String
    let backgroundColor: Color
    var onTap: TapHandler
    
    var body: some View {
        Button(action: onTap) {
            Text(title)
                .padding([.top, .bottom], 12)
                .padding([.leading, .trailing], 22)
                .foregroundColor(.white)
                .font(.buttonTitle)
        }
        .buttonStyle(
            FilledButtonStyle(backgroundColor: backgroundColor)
        )
    }
}

struct CaptureBar_Previews: PreviewProvider {
    static var previews: some View {
        CaptureOptionItemView(
            title: "Catch!",
            backgroundColor: .red,
            onTap: {}
        )
    }
}
