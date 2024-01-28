//
//  PokemonDetailRepository.swift
//  Pokefly
//
//  Created by Rodrigo Limpias Cossio on 27/1/24.
//

import Foundation
import Combine

protocol PokemonDetailRepositoryProtocol {
    func getPokemonDetail(id: String) -> AnyPublisher<DetailPokemon, NetworkError>
}

class PokemonDetailRepository: ObservableObject, PokemonDetailRepositoryProtocol {
    
    private let service: PokemonDetailServiceable
    
    init(service: PokemonDetailServiceable = PokemonDetailService()) {
        self.service = service
    }
    
    func getPokemonDetail(id: String) -> AnyPublisher<DetailPokemon, NetworkError> {
        service.getPokemonDetail(id: id)
            .map { DetailPokemonMapper.map(pokemon: $0) }
            .eraseToAnyPublisher()
    }
}
