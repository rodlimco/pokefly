//
//  PokemonsListView.swift
//  Pokefly
//
//  Created by Rodrigo Limpias Cossio on 27/1/24.
//

import SwiftUI

struct PokemonsListView: View {
    
    @StateObject private var viewModel = PokemonListViewModel()
    
    var body: some View {
        content
            .navigationTitle("Pokefly")
            .onAppear {
                viewModel.loadPokemons()
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
        List {
            ForEach(viewModel.pokemons) { pokemon in
                NavigationLink {
                    PokemonDetailView(viewModel: .init(pokemonId: pokemon.apiId))
                } label: {
                    PokemonsListItemView(pokemon: pokemon)
                }
            }

            ProgressView()
                .id(UUID())
                .frame(maxWidth: .infinity, alignment: .center)
                .onAppear {
                    viewModel.loadPokemons()
                }
        }
        .refreshable {
            viewModel.reload()
        }
    }
}

#Preview {
    PokemonsListView()
}
