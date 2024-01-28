//
//  PokemonDetailSection.swift
//  Pokefly
//
//  Created by Rodrigo Limpias Cossio on 28/1/24.
//

import Foundation

enum PokemonDetailSection: String {
    case abilities
    case moves
    case type
    
    var title: String {
        self.rawValue.capitalized
    }
}
