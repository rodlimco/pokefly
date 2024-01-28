//
//  PokemonDetailViewModel.swift
//  Pokefly
//
//  Created by Rodrigo Limpias Cossio on 28/1/24.
//

import Foundation
import Combine

class PokemonDetailViewModel: ObservableObject {
    
    private let pokemonId: Int!
    private let detailRepository: PokemonDetailRepositoryProtocol
    private var cancellables: [AnyCancellable] = []
    
    @Published private(set) var state: ViewState = .loading
    @Published private(set) var pokemon: DetailPokemon?
    
    init(
        pokemonId: Int,
        detailRepository: PokemonDetailRepositoryProtocol = PokemonDetailRepository()
    ) {
        self.pokemonId = pokemonId
        self.detailRepository = detailRepository
    }
    
    func loadPokemon() {
        if state != .loading {
            state = .loading
        }
        
        detailRepository.getPokemonDetail(id: pokemonId.toString)
            .subscribe(on: DispatchQueue.global())
            .receive(on: DispatchQueue.main)
            .sink { completion in
                if case .failure = completion {
                    self.state = .error
                }
            } receiveValue: { [weak self] responsePokemon in
                
                guard let self = self else { return }
                
                self.pokemon = responsePokemon
                state = .success
            }
            .store(in: &cancellables)

    }
}
