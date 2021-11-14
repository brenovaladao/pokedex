//
//  Configuration.swift
//  Pokedex
//
//  Created by Breno Valadão on 14/11/21.
//

import Foundation

import Foundation

public struct Configuration: Decodable {
    private enum CodingKeys: String, CodingKey {
        case apiBaseURL = "API_BASE_URL"
    }
    public let apiBaseURL: URL
}

// MARK: Static properties
public extension Configuration {
    static let `default`: Configuration = {
        guard let propertyList = Bundle.main.infoDictionary else {
            fatalError("Unable to get property list.")
        }

        guard let data = try? JSONSerialization.data(withJSONObject: propertyList, options: []) else {
            fatalError("Unable to instantiate data from property list.")
        }

        let decoder = JSONDecoder()

        guard let configuration = try? decoder.decode(Configuration.self, from: data) else {
            fatalError("Unable to decode the Environment configuration file.")
        }

        return configuration
    }()
}
