//
//  CacheError.swift
//  Pokedex
//
//  Created by Breno Valadão on 14/11/21.
//

import Foundation

public enum CacheError: Error, LocalizedError {
    case decoding
    case encoding
}
