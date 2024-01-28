//
//  PokemonListService.swift
//  Pokefly
//
//  Created by Rodrigo Limpias Cossio on 27/1/24.
//

import Foundation
import Combine

protocol PokemonListServiceable {
    func getPokemonList(
        limit: Int,
        offset: Int
    ) -> AnyPublisher<[APIPokemon], NetworkError>
}

class PokemonListService: PokemonListServiceable {
    
    private let urlSession: URLSession
    private var cancellables: [AnyCancellable] = []
    
    init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }
    
    func getPokemonList(limit: Int, offset: Int) -> AnyPublisher<[APIPokemon], NetworkError> {
        return Future { promise in
            do {
                let queryItems: [URLQueryItem] = [
                    .init(name: .limit, value: limit.toString),
                    .init(name: .offset, value: offset.toString)
                ]
                
                let url = try URLBuilder.create(path: .list, queryItems: queryItems)
                let responsePublisher: AnyPublisher<APIPokemonResponse, NetworkError> = self.urlSession.requestPublisher(url: url)
                
                responsePublisher
                    .subscribe(on: DispatchQueue.global())
                    .tryMap { response in
                        response.results
                    }
                    .sink(receiveCompletion: { completion in
                        if case .failure(let error) = completion {
                            promise(.failure(.wrapped(error)))
                        }
                    }, receiveValue: { results in
                        promise(.success(results))
                    })
                    .store(in: &self.cancellables)

            } catch {
                promise(.failure(.wrapped(error)))
            }
        }
        .eraseToAnyPublisher()
    }
}
