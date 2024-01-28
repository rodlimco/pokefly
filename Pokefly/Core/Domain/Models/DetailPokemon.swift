//
//  DetailPokemon.swift
//  Pokefly
//
//  Created by Rodrigo Limpias Cossio on 27/1/24.
//

import Foundation

struct DetailPokemon {
    let id: Int
    let abilities: [String]
    let moves: [String]
    let name: String
    let types: [String]
    let imagesUrls: DetailPokemonImages
    
    struct DetailPokemonImages {
        let front: String?
        let back: String?
        let dreamFront: String?
        let official: String?
    }
}
