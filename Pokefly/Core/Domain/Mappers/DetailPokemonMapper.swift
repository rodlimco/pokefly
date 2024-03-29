//
//  DetailPokemonMapper.swift
//  Pokefly
//
//  Created by Rodrigo Limpias Cossio on 27/1/24.
//

import Foundation

enum DetailPokemonMapper {
    static func map(pokemon: APIPokemonDetail) -> DetailPokemon {
        .init(
            id: pokemon.id,
            abilities: pokemon.abilities.map { $0.ability.name.capitalized }.sorted().joined(separator: ", "),
            moves: pokemon.moves.map { $0.move.name.capitalized }.sorted().joined(separator: ", "),
            name: pokemon.name,
            types: pokemon.types.map { $0.type.name.capitalized }.sorted().joined(separator: ", "),
            imagesUrls: .init(
                front: pokemon.sprites.frontDefault,
                back: pokemon.sprites.backDefault,
                dreamFront: pokemon.sprites.other?.dreamWorld?.frontDefault,
                official: pokemon.sprites.other?.officialArtwork?.frontDefault
            )
        )
    }
}
