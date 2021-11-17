//
//  APIManaging.swift
//  Pokedex
//
//  Created by Breno Valadão on 17/11/21.
//

import Foundation
import Combine

protocol APIManaging {
    var decoder: JSONDecoder { get }

    func fetch(url: URL) -> AnyPublisher<Data, Error>
}
