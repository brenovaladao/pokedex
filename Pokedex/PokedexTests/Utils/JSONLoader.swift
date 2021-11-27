//
//  JSONLoader.swift
//  PokedexTests
//
//  Created by Breno Valadão on 27/11/21.
//

import Foundation

final class JSONLoader {
    
    func decodeFromLocalJSON<T: Decodable>(objectType: T.Type, from file: String) -> T {
        let bundle = Bundle(for: type(of: self))
        
        guard let filePath = bundle.path(forResource: file, ofType: "json") else {
            fatalError("Failed to locate \(file) in bundle.")
        }
        
        let fileUrl = URL(fileURLWithPath: filePath)
        
        guard let data = try? Data(contentsOf: fileUrl) else {
            fatalError("Failed to load \(file) from bundle.")
        }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .iso8601

        do {
            return try decoder.decode(T.self, from: data)
        } catch DecodingError.keyNotFound(let key, let context) {
            fatalError("Failed to decode \(file) from bundle due to missing key '\(key.stringValue)' not found – \(context.debugDescription)")
        } catch DecodingError.typeMismatch(_, let context) {
            fatalError("Failed to decode \(file) from bundle due to type mismatch – \(context.debugDescription)")
        } catch DecodingError.valueNotFound(let type, let context) {
            fatalError("Failed to decode \(file) from bundle due to missing \(type) value – \(context.debugDescription)")
        } catch DecodingError.dataCorrupted(_) {
            fatalError("Failed to decode \(file) from bundle because it appears to be invalid JSON")
        } catch {
            fatalError("Failed to decode \(file) from bundle: \(error.localizedDescription)")
        }
    }
}
