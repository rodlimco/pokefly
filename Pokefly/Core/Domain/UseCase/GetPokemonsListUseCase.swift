//
//  GetPokemonsListUseCase.swift
//  Pokefly
//
//  Created by Rodrigo Limpias Cossio on 27/1/24.
//

import Foundation
import Combine

protocol GetPokemonsListUseCaseProtocol {
    func execute(
        limit: Int,
        offset: Int
    ) -> AnyPublisher<[ListPokemon], NetworkError>
}

extension GetPokemonsListUseCaseProtocol {
    func execute(
        limit: Int = 100,
        offset: Int = 0
    ) -> AnyPublisher<[ListPokemon], NetworkError> {
        execute(limit: limit, offset: offset)
    }
}

class GetPokemonsListUseCase: GetPokemonsListUseCaseProtocol {
    
    private let listRepository: PokemonListRepositoryProtocol
    private let detailRepository: PokemonDetailRepositoryProtocol
    
    init(
        listRepository: PokemonListRepositoryProtocol = PokemonListRepository(),
        detailRepository: PokemonDetailRepositoryProtocol = PokemonDetailRepository()
    ) {
        self.listRepository = listRepository
        self.detailRepository = detailRepository
    }
    
    func execute(
        limit: Int,
        offset: Int
    ) -> AnyPublisher<[ListPokemon], NetworkError> {
        getPokemonsList(
            limit: limit,
            offset: offset
        )
        .flatMap { pokemons -> AnyPublisher<[ListPokemon], NetworkError> in
            return self.getPokemonsDetail(ids: pokemons.map { $0.name })
        }
        .eraseToAnyPublisher()
    }

    private func getPokemonsList(
        limit: Int,
        offset: Int
    ) -> AnyPublisher<[Pokemon], NetworkError> {
        listRepository.getPokemonList(
            limit: limit,
            offset: offset
        )
    }
    
    private func getPokemonsDetail(ids: [String]) -> AnyPublisher<[ListPokemon], NetworkError> {
        let publishers = ids.map { id in
            self.detailRepository.getPokemonDetail(id: id)
                .eraseToAnyPublisher()
        }
        
        return Publishers.MergeMany(publishers)
            .collect()
            .map { pokemonDetails in
                return pokemonDetails.map { ListPokemonMapper.map(detailPokemon: $0) }
                    .sorted(by: { $0.name < $1.name })
            }
            .eraseToAnyPublisher()
    }
}
