//
//  StubsType.swift
//  PokeflyTests
//
//  Created by Rodrigo Limpias Cossio on 29/1/24.
//

import Foundation

enum StubsType {
    
    case pokemonDetail
    case pokemonResponse
    
    var filename: String {
        switch self {
        case .pokemonDetail: return "APIPokemonDetail.json"
        case .pokemonResponse: return "APIPokemonResponse.json"
        }
    }
}
