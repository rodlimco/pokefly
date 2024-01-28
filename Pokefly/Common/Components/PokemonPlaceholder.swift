//
//  PokemonPlaceholder.swift
//  Pokefly
//
//  Created by Rodrigo Limpias Cossio on 28/1/24.
//

import SwiftUI

struct PokemonPlaceholder: View {
    
    let size: CGSize
    
    var body: some View {
        Image("listImagePlaceholder")
            .resizable()
            .scaledToFit()
            .frame(width: size.width, height: size.height)
    }
}

#Preview {
    PokemonPlaceholder(size: .init(width: 50, height: 50))
}
