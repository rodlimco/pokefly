//
//  Bundle+.swift
//  PokeflyTests
//
//  Created by Rodrigo Limpias Cossio on 29/1/24.
//

import Foundation

enum BundleError: Error, Comparable {
    case fileNotFound(String)
    case decodingError(String)
}

extension Bundle {

    /// A function to decode any bundle JSON into an instance of the indicated type.
    /// - Parameters:
    ///   - type: Generic Codable type
    ///   - file: JSON file name
    ///   - dateDecodingStrategy: The strategies available for formatting dates when decoding them from JSON
    /// - Returns: Decoded object of indicated type
    @available(*, deprecated, message: "Use loadAndDecode<T: Decodable>(from fileName: String, decoder: JSONDecoder = .default) instead")
    func decode<T: Decodable>(_ type: T.Type,
                              from file: String,
                              dateDecodingStrategy: JSONDecoder.DateDecodingStrategy = .deferredToDate) -> T {

        guard let url = url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate \(file) in bundle.")
        }

        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(file) from bundle.")
        }

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = dateDecodingStrategy

        do {
            return try decoder.decode(T.self, from: data)
        } catch let DecodingError.keyNotFound(key, context) {
            fatalError("Failed to decode \(file) from bundle due to missing key '\(key.stringValue)' not found – \(context.debugDescription)")
        } catch let DecodingError.typeMismatch(_, context) {
            fatalError("Failed to decode \(file) from bundle due to type mismatch – \(context.debugDescription)")
        } catch let DecodingError.valueNotFound(type, context) {
            fatalError("Failed to decode \(file) from bundle due to missing \(type) value – \(context.debugDescription)")
        } catch DecodingError.dataCorrupted(_) {
            fatalError("Failed to decode \(file) from bundle because it appears to be invalid JSON")
        } catch {
            fatalError("Failed to decode \(file) from bundle: \(error.localizedDescription)")
        }
    }

    var versionNumber: String? {
        infoDictionary?["CFBundleShortVersionString"] as? String
    }
}

extension Bundle {

    func loadData(for fileName: String) throws -> Data {

        guard let url = url(forResource: fileName, withExtension: nil) else {
            throw BundleError.fileNotFound("Failed to locate \(fileName) in bundle.")
        }

        return try Data(contentsOf: url)
    }

    func loadAndDecode<T: Decodable>(
        from fileName: String,
        decoder: JSONDecoder = JSONDecoder()
    ) throws -> T {

        let data = try loadData(for: fileName)

        do {
            return try decoder.decode(T.self, from: data)

        } catch let DecodingError.keyNotFound(key, context) {
            throw BundleError.decodingError(
                "Failed to decode \(fileName) from bundle due to missing key " +
                    "'\(key.stringValue)' not found – \(context.debugDescription)"
            )

        } catch let DecodingError.typeMismatch(_, context) {
            throw BundleError.decodingError(
                "Failed to decode \(fileName) from bundle due to type mismatch – \(context.debugDescription)"
            )

        } catch let DecodingError.valueNotFound(type, context) {
            throw BundleError.decodingError(
                "Failed to decode \(fileName) from bundle due to missing \(type) value" +
                    " – \(context.debugDescription)"
            )

        } catch DecodingError.dataCorrupted {
            throw BundleError.decodingError(
                "Failed to decode \(fileName) from bundle because it appears to be invalid JSON"
            )

        } catch {
            throw BundleError.decodingError(
                "Failed to decode \(fileName) from bundle: \(error.localizedDescription)"
            )
        }
    }
}
