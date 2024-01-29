//
//  APIPokemonDetail+Dummy.swift
//  PokeflyTests
//
//  Created by Rodrigo Limpias Cossio on 29/1/24.
//

import Foundation
@testable import Pokefly

extension APIPokemonDetail {
    static func dummy(
        name: String = "pikachu",
        id: Int = 1,
        moves: [APIMove] = [.dummy()],
        abilities: [APIAbility] = [.dummy()],
        sprites: APISprites = .dummy(),
        types: [APIType] = [.dummy()]
    ) -> APIPokemonDetail {
        return APIPokemonDetail(
            abilities: abilities,
            id: id,
            moves: moves,
            name: name,
            sprites: sprites,
            types: types
        )
    }
}

extension APIPokemonDetail.APISprites {
    static func dummy() -> APIPokemonDetail.APISprites {
        return APIPokemonDetail.APISprites(
            backDefault: nil,
            frontDefault: nil,
            other: APIOther.dummy()
        )
    }
}

extension APIPokemonDetail.APISprites.APIOther {
    static func dummy() -> APIPokemonDetail.APISprites.APIOther {
        return APIPokemonDetail.APISprites.APIOther(
            dreamWorld: nil,
            officialArtwork: nil
        )
    }
}

extension APIPokemonDetail.APIMove {
    static func dummy(name: String = "dummyName") -> APIPokemonDetail.APIMove {
        return APIPokemonDetail.APIMove(move: APIMoveInfo(name: name))
    }
}

extension APIPokemonDetail.APIAbility {
    static func dummy(name: String = "dummyName") -> APIPokemonDetail.APIAbility {
        return APIPokemonDetail.APIAbility(ability: APIAbilityInfo(name: name))
    }
}

extension APIPokemonDetail.APIType {
    static func dummy(name: String = "dummyName") -> APIPokemonDetail.APIType {
        return APIPokemonDetail.APIType(type: APITypeInfo(name: name))
    }
}
