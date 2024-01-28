//
//  PokemonListViewModel.swift
//  Pokefly
//
//  Created by Rodrigo Limpias Cossio on 27/1/24.
//

import Foundation
import Combine

class PokemonListViewModel: ObservableObject {
    
    private let getPokemonsListUseCase: GetPokemonsListUseCaseProtocol
    private var currentOffset = 0
    private var cancellables: [AnyCancellable] = []
    
    @Published private(set) var state: ViewState = .loading
    @Published private(set) var pokemons: [ListPokemon] = []
    
    init(getPokemonsListUseCase: GetPokemonsListUseCaseProtocol = GetPokemonsListUseCase()) {
        self.getPokemonsListUseCase = getPokemonsListUseCase
    }
    
    func loadPokemons() {
        if state != .loading {
            state = .loading
        }
        
        getPokemonsListUseCase.execute(offset: currentOffset)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                if case .failure = completion {
                    self.state = .error
                }
            } receiveValue: { [weak self] responsePokemons in
                
                guard let self = self else { return }
                
                currentOffset += 100
                pokemons += responsePokemons
                state = .success
            }
            .store(in: &cancellables)
    }
}
