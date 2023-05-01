//
//  ViewModel.swift
//  PokeWiki
//
//  Created by Zhydani Reis benigno  on 30/04/23.
//

import SwiftUI

class ViewModel: ObservableObject {
    private let pokemonManager = PokemonManager()
    
    @Published var pokemonList = [Pokemon]()
    @Published var pokemonDetails: DetailPokemon?
    // text para o campo de busca de pokemon especifico
    @Published var searchText = ""
    
    // pega o text para filtrar os pokemons especificos e retornar ele na lista
    var filteredPokemon: [Pokemon] {
                return searchText == "" ? pokemonList : pokemonList.filter { $0.name.contains(searchText.lowercased()) }
            }
    
    init() {
        // a lista receber os pokemons do json
        self.pokemonList = pokemonManager.getPokemon()
    }
    
    // pega o index do array de pokemons ( index + 1 = pokemon id) para retornar o detalhe na api
    func getPokemonIndex(pokemon: Pokemon) -> Int {
        if let index = self.pokemonList.firstIndex(of: pokemon) {
            return index + 1
        }
        return 0
    }
    
    // pegando os detalhes do pokemon especifico
    func getDetails(pokemon: Pokemon) {
        let id = getPokemonIndex(pokemon: pokemon)
        
        self.pokemonDetails = DetailPokemon(id: 0, height: 0, weight: 0)
        
        pokemonManager.getDetailedPokemon(id: id) { data in
            DispatchQueue.main.async {
                self.pokemonDetails = data
            }
        }
    }
    
    // Format da altura e do peso do pokemon no detalhe
    func formatHW(value: Int) -> String {
        let dValue = Double(value)
        let string = String(format: "%.2f", dValue / 10)
        
        return string
    }
}
