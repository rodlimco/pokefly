//
//  PokemonDetailServiceTests.swift
//  PokeflyTests
//
//  Created by Rodrigo Limpias Cossio on 29/1/24.
//

import XCTest
import Combine
@testable import Pokefly

final class PokemonDetailServiceTests: XCTestCase {
    
    var urlSession: URLSession!
    var detailService: PokemonDetailServiceable!

    override func setUpWithError() throws {
        urlSession = .test
        detailService = PokemonDetailService(urlSession: urlSession)
    }

    override func tearDownWithError() throws {
        urlSession = nil
        detailService = nil
    }
    
    func test_GetPokemonDetail_ReturnsResult() throws {
        let mockData = try TestsBundle.test.loadData(for: StubsType.pokemonDetail.filename)
        
        MockURLProtocol.requestHandler = { _ in
            (HTTPURLResponse(), mockData)
        }
        
        let cancellable = detailService.getPokemonDetail(id: "id")
            .sink(
                receiveCompletion: { _ in },
                receiveValue: { response in
                    XCTAssertNotNil(response)
                    XCTAssertEqual(response.name, "pikachu")
                }
            )
        
        cancellable.cancel()
    }
    
    func test_GetPokemonDetail_ThrowsError() throws {
        let _ = urlResponseExpectation(data: nil)
        
        let cancellable = detailService.getPokemonDetail(id: "id")
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
