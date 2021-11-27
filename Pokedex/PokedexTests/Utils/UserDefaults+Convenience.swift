//
//  UserDefaults+Convenience.swift
//  PokedexTests
//
//  Created by Breno Valadão on 27/11/21.
//

import Foundation

extension UserDefaults {
    func clearAllKeys() {
        dictionaryRepresentation().keys.forEach { key in
            set(nil, forKey: key)
        }
    }
}
