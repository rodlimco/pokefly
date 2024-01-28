//
//  PokemonsListItemView.swift
//  Pokefly
//
//  Created by Rodrigo Limpias Cossio on 28/1/24.
//

import SwiftUI
import SDWebImageSwiftUI

struct PokemonsListItemView: View {
    
    let pokemon: ListPokemon
    
    var body: some View {
        content
    }
    
    private var content: some View {
        HStack(spacing: Constants.horizontalSpacing) {
            pokemonImage
            pokemonInfo
        }
    }
    
    @ViewBuilder
    private var pokemonImage: some View {
        if let imageUrl = pokemon.imageUrl {
            WebImage(url: URL(string: imageUrl))
                .resizable()
                .placeholder {
                    placeholderImage
                }
                .indicator(.progress)
                .transition(.fade(duration: 0.5))
                .scaledToFill()
                .frame(width: Constants.imageSize.width, height: Constants.imageSize.height)
        } else {
            placeholderImage
        }
    }
    
    private var pokemonInfo: some View {
        VStack(
            alignment: .leading,
            spacing: Constants.verticalSpacing
        ) {
            Text(pokemon.name.capitalized)
                .font(.system(size: Constants.nameFontSize, weight: .semibold))
            
            Text(pokemon.types.joined(separator: ", "))
                .font(.system(size: Constants.typesFontSize, weight: .thin))
        }
    }
    
    private var placeholderImage: some View {
        Image("listImagePlaceholder")
            .resizable()
            .scaledToFit()
            .frame(width: Constants.imageSize.width, height: Constants.imageSize.height)
    }
}

private extension PokemonsListItemView {
    enum Constants {
        static let nameFontSize: CGFloat = 16
        static let typesFontSize: CGFloat = 12
        static let imageSize: CGSize = .init(width: 50, height: 50)
        static let horizontalSpacing: CGFloat = 10
        static let verticalSpacing: CGFloat = 4
    }
}



#Preview {
    PokemonsListItemView(pokemon: .init(name: "pikachu", apiId: 1, imageUrl: nil, types: ["electric, type2", "type3"]))
}
