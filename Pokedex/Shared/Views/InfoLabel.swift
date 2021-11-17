//
//  InfoLabel.swift
//  Pokedex
//
//  Created by Breno Valadão on 17/11/21.
//

import SwiftUI

struct InfoLabel: View {
    let title: String
    let info: String
    
    var body: some View {
        Text("\(title): ").bold() + Text(info)
    }
}

struct InfoLabel_Previews: PreviewProvider {
    static var previews: some View {
        InfoLabel(title: "Name", info: "Pikachu")
    }
}
