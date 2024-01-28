//
//  PokemonsListItemView.swift
//  Pokefly
//
//  Created by Rodrigo Limpias Cossio on 28/1/24.
//

import SwiftUI

struct PokemonsListItemView: View {
    
    let pokemon: ListPokemon
    
    var body: some View {
        content
    }
    
    private var content: some View {
        HStack(
            alignment: .center,
            spacing: 10
        ) {
            Rectangle()
                .fill(.red)
                .frame(width: 40, height: 40)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(pokemon.name.capitalized)
                    .font(.system(size: 16, weight: .semibold))
                
                Text(pokemon.types.joined(separator: ", "))
                    .font(.system(size: 12, weight: .thin))
            }
        }
    }
}

#Preview {
    PokemonsListItemView(pokemon: .init(name: "pikachu", apiId: 1, imageUrl: nil, types: ["electric, type2", "type3"]))
}
