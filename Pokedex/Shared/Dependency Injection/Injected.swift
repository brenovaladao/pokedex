//
//  Injected.swift
//  Pokedex
//
//  Created by Breno Valadão on 14/11/21.
//

@propertyWrapper
struct Injected<T> {
    let wrappedValue: T

    init() {
        wrappedValue = DIContainer.shared.resolve()
    }
}
