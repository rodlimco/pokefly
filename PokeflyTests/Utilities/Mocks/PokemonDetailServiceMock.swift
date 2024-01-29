//
//  PokemonDetailServiceMock.swift
//  PokeflyTests
//
//  Created by Rodrigo Limpias Cossio on 29/1/24.
//

import Foundation
import Combine
@testable import Pokefly

class PokemonDetailServiceMock: PokemonDetailServiceable {
    
    var getPokemonDetailClosure: ((String) -> AnyPublisher<APIPokemonDetail, NetworkError>)!
    func getPokemonDetail(id: String) -> AnyPublisher<APIPokemonDetail, NetworkError> {
        getPokemonDetailClosure(id)
    }
}
