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
    }
    
    private var content: some View {
        List {
            ForEach(viewModel.pokemons, id: \.id) { pokemon in
                NavigationLink {
                    Text(pokemon.name.capitalized)
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
            viewModel.loadPokemons()
        }
    }
}

#Preview {
    PokemonsListView()
}
