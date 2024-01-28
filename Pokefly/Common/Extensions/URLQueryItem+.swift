//
//  URLQueryItem+.swift
//  Pokefly
//
//  Created by Rodrigo Limpias Cossio on 28/1/24.
//

import Foundation

extension URLQueryItem {
    init(name: PaginationQueryItem, value: String?) {
        self.init(name: name.rawValue, value: value)
    }
}
