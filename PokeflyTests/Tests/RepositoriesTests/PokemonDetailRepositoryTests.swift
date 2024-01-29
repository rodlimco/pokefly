//
//  PokemonDetailRepositoryTests.swift
//  PokeflyTests
//
//  Created by Rodrigo Limpias Cossio on 29/1/24.
//

import XCTest
import Combine
@testable import Pokefly

final class PokemonDetailRepositoryTests: XCTestCase {

    var pokemonDetailService: PokemonDetailServiceMock!
    var pokemonDetailRepository: PokemonDetailRepositoryProtocol!

    override func setUpWithError() throws {
        pokemonDetailService = PokemonDetailServiceMock()
        pokemonDetailRepository = PokemonDetailRepository(service: pokemonDetailService)
    }

    override func tearDownWithError() throws {
        pokemonDetailService = nil
        pokemonDetailRepository = nil
    }

    func test_GetPokemonDetail_ReturnsData() {
        let apiPokemon: APIPokemonDetail = .dummy()
        
        pokemonDetailService.getPokemonDetailClosure = { _ in
            Just(apiPokemon)
                .setFailureType(to: NetworkError.self)
                .eraseToAnyPublisher()
        }
        
        let cancellable = pokemonDetailRepository
            .getPokemonDetail(id: "id")
            .sink { _ in } receiveValue: { pokemon in
                XCTAssertNotNil(pokemon)
                XCTAssertEqual(pokemon.name, "pikachu")
            }
        
        cancellable.cancel()
    }
    
    func test_GetPokemonDetail_ThrowsError() {
        pokemonDetailService.getPokemonDetailClosure = { _ in
            Just(APIPokemonDetail.dummy())
                .tryMap { _ -> APIPokemonDetail in
                    throw NetworkError.noData
                }
                .mapError { error in
                    NetworkError.wrapped(error)
                }
                .eraseToAnyPublisher()
        }
        
        let throwingExpectation = expectation(description: "throwingExpectation")
        
        let cancellable = pokemonDetailRepository.getPokemonDetail(id: "id")
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
