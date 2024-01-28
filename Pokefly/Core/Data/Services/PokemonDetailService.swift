//
//  PokemonDetailService.swift
//  Pokefly
//
//  Created by Rodrigo Limpias Cossio on 27/1/24.
//

import Foundation
import Combine

protocol PokemonDetailServiceable {
    func getPokemonDetail(id: String) -> AnyPublisher<APIPokemonDetail, NetworkError>
}

class PokemonDetailService: PokemonDetailServiceable {
    private let urlSession: URLSession
    private var cancellables: [AnyCancellable] = []
    
    init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }
    
    func getPokemonDetail(id: String) -> AnyPublisher<APIPokemonDetail, NetworkError> {
        return Future { promise in
            do {
                let url = try URLBuilder.create(path: .detail(id: id))
                let responsePublisher: AnyPublisher<APIPokemonDetail, NetworkError> = self.urlSession.requestPublisher(url: url)
                
                responsePublisher
                    .subscribe(on: DispatchQueue.global())
                    .sink(receiveCompletion: { completion in
                        if case .failure(let error) = completion {
                            promise(.failure(.wrapped(error)))
                        }
                    }, receiveValue: { pokemon in
                        promise(.success(pokemon))
                    })
                    .store(in: &self.cancellables)

            } catch {
                promise(.failure(.wrapped(error)))
            }
        }
        .eraseToAnyPublisher()
    }
}
