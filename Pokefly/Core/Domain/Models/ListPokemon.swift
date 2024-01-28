//
//  ListPokemon.swift
//  Pokefly
//
//  Created by Rodrigo Limpias Cossio on 27/1/24.
//

import Foundation

struct ListPokemon: Identifiable {
    let name: String
    let apiId: Int
    let imageUrl: String?
    let types: [String]
    
    var id: String {
        UUID().uuidString
    }
}
