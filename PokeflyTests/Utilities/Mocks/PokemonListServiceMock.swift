//
//  PokemonListServiceMock.swift
//  PokeflyTests
//
//  Created by Rodrigo Limpias Cossio on 29/1/24.
//

import Foundation
import Combine
@testable import Pokefly

class PokemonListServiceMock: PokemonListServiceable {
    
    var getPokemonListClosure: (() -> AnyPublisher<[APIPokemon], NetworkError>)!
    func getPokemonList(
        limit: Int,
        offset: Int
    ) -> AnyPublisher<[APIPokemon], NetworkError> {
        getPokemonListClosure()
    }
}
