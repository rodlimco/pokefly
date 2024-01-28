//
//  PokemonDetailView.swift
//  Pokefly
//
//  Created by Rodrigo Limpias Cossio on 28/1/24.
//

import SwiftUI

struct PokemonDetailView: View {
    
    @StateObject var viewModel: PokemonDetailViewModel
    
    var body: some View {
        content
            .onAppear {
                viewModel.loadPokemon()
            }
    }
    
    @ViewBuilder
    private var content: some View {
        switch viewModel.state {
        case .loading:
            ProgressView()
        case .success:
            successView
        default:
            EmptyView()
            // TODO: handle other states
        }
    }
    
    private var successView: some View {
        ScrollView {
            VStack(
                alignment: .center,
                spacing: Constants.spacingTwenty
            ) {
                DetailImagesCarouselView(viewModel: .init(imagesUrls: viewModel.pokemon?.imagesUrls))
                
                VStack(
                    alignment: .leading,
                    spacing: Constants.spacingTwenty
                ) {
                    Text(viewModel.pokemon?.name.capitalized ?? "")
                        .font(.system(size: Constants.nameFontSize, weight: .semibold))
                    sectionBuilder(section: .abilities, content: viewModel.pokemon?.abilities ?? "")
                    sectionBuilder(section: .moves, content: viewModel.pokemon?.moves ?? "")
                    sectionBuilder(section: .type, content: viewModel.pokemon?.types ?? "")
                }
            }
            .padding([.horizontal, .bottom], Constants.paddingSixteen)
        }
    }
    
    private func sectionBuilder(
        section: PokemonDetailSection,
        content: String
    ) -> some View {
        VStack(
            alignment: .leading,
            spacing: Constants.spacingFour
        ) {
            Text(section.title)
                .font(.system(size: Constants.sectionFontSize, weight: .semibold))
            
            Text(content)
                .font(.system(size: Constants.contentFontSize, weight: .regular))
        }
    }
}

private extension PokemonDetailView {
    enum Constants {
        static let contentFontSize: CGFloat = 16
        static let nameFontSize: CGFloat = 24
        static let sectionFontSize: CGFloat = 18
        static let paddingSixteen: CGFloat = 16
        static let spacingFour: CGFloat = 4
        static let spacingTwenty: CGFloat = 20
    }
}

#Preview {
    PokemonDetailView(viewModel: .init(pokemonId: 1))
}
