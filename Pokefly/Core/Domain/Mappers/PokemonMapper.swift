//
//  PokemonMapper.swift
//  Pokefly
//
//  Created by Rodrigo Limpias Cossio on 27/1/24.
//

import Foundation

enum PokemonMapper {
    static func map(apiPokemons: [APIPokemon]) -> [Pokemon] {
        apiPokemons.map { map(apiPokemon: $0) }
    }

    static func map(apiPokemon: APIPokemon) -> Pokemon {
        .init(
            name: apiPokemon.name,
            detailUrl: apiPokemon.detailUrl
        )
    }
}
