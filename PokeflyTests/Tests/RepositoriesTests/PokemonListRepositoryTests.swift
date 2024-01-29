//
//  PokemonListRepositoryTests.swift
//  PokeflyTests
//
//  Created by Rodrigo Limpias Cossio on 29/1/24.
//

import XCTest
import Combine
@testable import Pokefly

final class PokemonListRepositoryTests: XCTestCase {
    
    var pokemonListService: PokemonListServiceMock!
    var pokemonListRepository: PokemonListRepositoryProtocol!
    

    override func setUpWithError() throws {
        pokemonListService = PokemonListServiceMock()
        pokemonListRepository = PokemonListRepository(service: pokemonListService)
    }

    override func tearDownWithError() throws {
        pokemonListService = nil
        pokemonListRepository = nil
    }

    func test_GetPokemonList_ReturnResult() {
        let apiPokemon: APIPokemon = .dummy()
        
        pokemonListService.getPokemonListClosure = {
            Just([apiPokemon])
                .setFailureType(to: NetworkError.self)
                .eraseToAnyPublisher()
        }
        
        let cancellable = pokemonListRepository.getPokemonList(limit: 10, offset: 10)
            .sink { _ in } receiveValue: { pokemons in
                XCTAssertFalse(pokemons.isEmpty)
                XCTAssertEqual(pokemons.first!.name, apiPokemon.name)
            }

        cancellable.cancel()
    }

    func test_GetPokemonsList_ThrowsError() {
        pokemonListService.getPokemonListClosure = {
            Just([])
                .tryMap { _ -> [APIPokemon] in
                    throw NetworkError.invalidRequest
                }
                .mapError{ error in
                    NetworkError.wrapped(error)
                }
                .eraseToAnyPublisher()
        }
        
        let throwingExpectation = expectation(description: "throwingExpectation")
        
        let cancellable = pokemonListRepository.getPokemonList(limit: 10, offset: 10)
            .sink { completion in
                if case .failure = completion {
                    throwingExpectation.fulfill()
                }
            } receiveValue: { response in
                XCTFail("Unexpected value: \(response)")
            }
        
        waitForExpectations(timeout: 0.1)

        cancellable.cancel()
    }
}
