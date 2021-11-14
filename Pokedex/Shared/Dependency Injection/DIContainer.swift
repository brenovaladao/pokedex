//
//  DIContainer.swift
//  Pokedex
//
//  Created by Breno Valadão on 14/11/21.
//

import Foundation

final class DIContainer {
    typealias Resolver = () -> Any

    private var resolvers = [String: Resolver]()
    private var cache = [String: Any]()

    static let shared = DIContainer()

    init() {
        registerDependencies()
    }

    func register<T, R>(_ type: T.Type, cached: Bool = false, service: @escaping () -> R) {
        let key = String(reflecting: type)
        resolvers[key] = service

        if cached {
            cache[key] = service()
        }
    }

    func resolve<T>() -> T {
        let key = String(reflecting: T.self)

        if let cachedService = cache[key] as? T {
            return cachedService
        }

        if let resolver = resolvers[key], let service = resolver() as? T {
            return service
        }

        fatalError("\(key) has not been registered.")
    }
}

private extension DIContainer {
    func registerDependencies() {
        register(APIManaging.self, cached: true) {
            APIManager()
        }
    }
}
