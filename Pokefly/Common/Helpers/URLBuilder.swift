//
//  URLBuilder.swift
//  Pokefly
//
//  Created by Rodrigo Limpias Cossio on 27/1/24.
//

import Foundation

enum URLBuilder {
    static func create(
        path: PokemonPath,
        queryItems: [URLQueryItem]? = nil
    ) throws -> URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "pokeapi.co"
        components.path = path.stringLiteral
        components.queryItems = queryItems
        
        guard let url = components.url else {
            throw NetworkError.invalidUrl
        }
        
        return url
    }
}

extension URLBuilder {
    enum PokemonPath {
        case list
        case detail(id: String)
        
        var stringLiteral: String {
            switch self {
            case .list:
                "/api/v2/pokemon"
            case .detail(let id):
                "/api/v2/pokemon/\(id.lowercased())"
            }
        }
    }
}
