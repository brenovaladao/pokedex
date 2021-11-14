//
//  SearchStoreState.swift
//  Pokedex
//
//  Created by Breno Valadão on 14/11/21.
//

import Foundation

extension SearchStore {
    struct State {
        let isLoading: Bool
        let loaded: Loaded
        let error: Error?
    
        init(isLoading: Bool = false,
             loaded: Loaded,
             error: Error? = nil) {
            self.isLoading = isLoading
            self.loaded = loaded
            self.error = error
        }
        
        var isEmpty: Bool {
            if case .empty = loaded {
                return true
            }
            return false
        }
    }
    
    enum Loaded {
        case pokemon(Pokemon)
        case empty
    }
}
