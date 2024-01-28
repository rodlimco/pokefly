//
//  DetailImagesCarouselView.swift
//  Pokefly
//
//  Created by Rodrigo Limpias Cossio on 28/1/24.
//

import SwiftUI
import SDWebImageSwiftUI

struct DetailImagesCarouselView: View {
    
    let viewModel: DetailImagesCarouselViewModel
    
    var body: some View {
        content
    }
    
    private var content: some View {
        ScrollView(.horizontal) {
            LazyHStack(spacing: 0) {
                ForEach(viewModel.urls, id: \.self) { imageUrl in
                    WebImage(url: URL(string: imageUrl))
                        .resizable()
                        .placeholder {
                            PokemonPlaceholder(
                                size: .init(
                                    width: Constants.placeholderSize.width,
                                    height: Constants.placeholderSize.height
                                )
                            )
                        }
                        .transition(.fade(duration: 0.5))
                        .scaledToFit()
                        .padding(.horizontal, Constants.horizontalPadding)
                        .containerRelativeFrame(.horizontal)
                        .scrollTransition(.animated, axis: .horizontal) { content, phase in
                            content
                                .opacity(phase.isIdentity ? 1.0 : 0.8)
                                .scaleEffect(phase.isIdentity ? 1.0 : 0.8)
                        }
                    
                }
            }
            .scrollTargetLayout()
        }
    }
}

private extension DetailImagesCarouselView {
    enum Constants {
        static let placeholderSize: CGSize = .init(width: 200, height: 200)
        static let horizontalPadding: CGFloat = 20
    }
}

#Preview {
    DetailImagesCarouselView(
        viewModel: .init(
            imagesUrls: .init(
                front: nil,
                back: nil,
                dreamFront: nil,
                official: nil
            )
        )
    )
}
