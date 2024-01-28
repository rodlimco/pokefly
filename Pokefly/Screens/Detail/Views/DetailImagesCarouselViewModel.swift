//
//  DetailImagesCarouselViewModel.swift
//  Pokefly
//
//  Created by Rodrigo Limpias Cossio on 28/1/24.
//

import Foundation

class DetailImagesCarouselViewModel {
    
    private let imagesUrls: DetailPokemon.DetailPokemonImages?
    var urls: [String] {
        [
            imagesUrls?.official,
            imagesUrls?.front,
            imagesUrls?.back
        ]
            .compactMap { $0 }
    }
    
    init(imagesUrls: DetailPokemon.DetailPokemonImages?) {
        self.imagesUrls = imagesUrls
    }
}
