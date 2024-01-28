//
//  URLSession+.swift
//  Pokefly
//
//  Created by Rodrigo Limpias Cossio on 27/1/24.
//

import Foundation
import Combine

extension URLSession {
    func requestPublisher<T: Decodable>(
        url: URL,
        decoder: JSONDecoder = JSONDecoder()
    ) -> AnyPublisher<T, NetworkError> {
        self.dataTaskPublisher(for: url)
            .tryMap { data, _ in
                do {
                    return try decoder.decode(T.self, from: data)
                } catch {
                    throw NetworkError.decoding(error)
                }
            }
            .mapError(NetworkError.wrapped(_:))
            .eraseToAnyPublisher()
    }
}
