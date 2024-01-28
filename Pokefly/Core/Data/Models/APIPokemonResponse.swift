//
//  APIPokemonResponse.swift
//  Pokefly
//
//  Created by Rodrigo Limpias Cossio on 26/1/24.
//

import Foundation

struct APIPokemonResponse: Decodable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [APIPokemon]
}

struct APIPokemon: Decodable {
    let name: String
    let detailUrl: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case detailUrl = "url"
    }
}
