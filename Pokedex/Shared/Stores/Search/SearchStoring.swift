//
//  SearchStoring.swift
//  Pokedex
//
//  Created by Breno Valadão on 14/11/21.
//

import Foundation

public protocol SearchStoring {
    func fetchRandomPokemon()
    
    func setInitialState()
    
    func captureCurrentPokemon()
}
