//
//  NetworkError.swift
//  Pokefly
//
//  Created by Rodrigo Limpias Cossio on 27/1/24.
//

import Foundation
import Combine

enum NetworkError: Error {
    case custom(statusCode: Int, message: String?)
    case decoding(Error)
    case invalidRequest
    case invalidUrl
    case noData
    case other(Error)

    static func wrapped(_ error: Error) -> NetworkError {
        if let nwError = error as? NetworkError {
            return nwError
        } else if let decodingError = error as? DecodingError {
            return .decoding(decodingError)
        } else {
            return .other(error)
        }
    }
}
