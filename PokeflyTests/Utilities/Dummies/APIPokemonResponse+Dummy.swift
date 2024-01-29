//
//  APIPokemonResponse+Dummy.swift
//  PokeflyTests
//
//  Created by Rodrigo Limpias Cossio on 29/1/24.
//

import Foundation
@testable import Pokefly

extension APIPokemonResponse {
    static func dummy(
        count: Int = 10,
        next: String? = nil,
        previous: String? = nil,
        results: [APIPokemon] = [.dummy()]
    ) -> APIPokemonResponse {
        .init(
            count: count,
            next: next,
            previous: previous,
            results: results
        )
    }
}

extension APIPokemon {
    static func dummy(
        name: String = "pikachu",
        detailUrl: String = "https://pokeapi.co/api/v2/pokemon/pikachu"
    ) -> APIPokemon {
        .init(
            name: name,
            detailUrl: detailUrl
        )
    }
}
