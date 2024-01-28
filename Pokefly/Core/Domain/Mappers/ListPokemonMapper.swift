//
//  ListPokemonMapper.swift
//  Pokefly
//
//  Created by Rodrigo Limpias Cossio on 27/1/24.
//

import Foundation

enum ListPokemonMapper {
    static func map(apiPokemon: APIPokemonDetail) -> ListPokemon {
        .init(
            name: apiPokemon.name,
            apiId: apiPokemon.id,
            imageUrl: apiPokemon.sprites.frontDefault,
            types: apiPokemon.types.map { $0.type.name.capitalized }.joined(separator: ", ")
        )
    }
    
    static func map(detailPokemon: DetailPokemon) -> ListPokemon {
        .init(
            name: detailPokemon.name,
            apiId: detailPokemon.id,
            imageUrl: detailPokemon.imagesUrls.official,
            types: detailPokemon.types
        )
    }
}
