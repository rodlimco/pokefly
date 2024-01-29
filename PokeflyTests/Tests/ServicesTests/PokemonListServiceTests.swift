//
//  PokemonListServiceTests.swift
//  PokeflyTests
//
//  Created by Rodrigo Limpias Cossio on 25/1/24.
//

import XCTest
import Combine
@testable import Pokefly

final class PokemonListServiceTests: XCTestCase {
    
    var urlSession: URLSession!
    var listService: PokemonListServiceable!

    override func setUpWithError() throws {
        urlSession = .test
        listService = PokemonListService(urlSession: urlSession)
    }

    override func tearDownWithError() throws {
        urlSession = nil
        listService = nil
    }
    
    func test_GetPokemonList_ReturnsResult() throws {
        let mockData = try TestsBundle.test.loadData(for: StubsType.pokemonResponse.filename)
        
        MockURLProtocol.requestHandler = { _ in
            (HTTPURLResponse(), mockData)
        }
        
        let cancellable = listService.getPokemonList(limit: 10, offset: 10)
            .sink(
                receiveCompletion: { _ in },
                receiveValue: { response in
                    XCTAssertFalse(response.isEmpty)
                }
            )
        
        cancellable.cancel()
    }
    
    func test_GetPokemonList_ThrowsError() throws {
        let _ = urlResponseExpectation(data: nil)
        
        let cancellable = listService.getPokemonList(limit: 10, offset: 10)
            .sink(
                receiveCompletion: { _ in }, receiveValue: { response in
                    XCTFail("Unexpected value: \(response)")
                }
            )
        
        waitForExpectations(timeout: 0.1)
        cancellable.cancel()
    }
    
    private func urlResponseExpectation(
        data: Data?,
        response: HTTPURLResponse = .init()
    ) -> XCTestExpectation {

        let urlResponseExpectation = expectation(description: "urlResponseExpectation")
        MockURLProtocol.requestHandler = { _ in
            urlResponseExpectation.fulfill()
            guard let data = data else { throw MockError.💣 }
            return (response, data)
        }
        return urlResponseExpectation
    }
}
