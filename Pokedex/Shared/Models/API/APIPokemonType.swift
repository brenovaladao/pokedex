//
//  APIPokemonType.swift
//  Pokedex
//
//  Created by Breno Valadão on 17/11/21.
//

import Foundation

struct APIPokemonType: Decodable {
    let name: String

    private enum CodingKeys: String, CodingKey {
        case type
        
        enum Fields: String, CodingKey {
            case name
        }
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let nestedContainer = try container.nestedContainer(keyedBy: CodingKeys.Fields.self, forKey: .type)
        name = try nestedContainer.decode(String.self, forKey: .name)
    }
}
