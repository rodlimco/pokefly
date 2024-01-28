//
//  PokemonListRepository.swift
//  Pokefly
//
//  Created by Rodrigo Limpias Cossio on 27/1/24.
//

import Foundation
import Combine

protocol PokemonListRepositoryProtocol {
    func getPokemonList(
        limit: Int,
        offset: Int
    ) -> AnyPublisher<[Pokemon], NetworkError>
}

extension PokemonListRepositoryProtocol {
    func getPokemonList(
        limit: Int = 100,
        offset: Int = 0
    ) -> AnyPublisher<[Pokemon], NetworkError> {
        getPokemonList(limit: limit, offset: offset)
    }
}

class PokemonListRepository: ObservableObject, PokemonListRepositoryProtocol {
    
    private let service: PokemonListServiceable
    
    init(service: PokemonListServiceable = PokemonListService()) {
        self.service = service
    }
    
    func getPokemonList(
        limit: Int,
        offset: Int
    ) -> AnyPublisher<[Pokemon], NetworkError> {
        service.getPokemonList(
            limit: limit,
            offset: offset
        )
        .receive(on: DispatchQueue.main)
        .map { PokemonMapper.map(apiPokemons: $0) }
        .eraseToAnyPublisher()
    }
}
