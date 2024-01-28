//
//  PokeflyApp.swift
//  Pokefly
//
//  Created by Rodrigo Limpias Cossio on 25/1/24.
//

import SwiftUI

@main
struct PokeflyApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                PokemonsListView()
            }
        }
    }
}
