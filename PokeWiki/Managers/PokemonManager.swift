//
//  PokemonManager.swift
//  PokeWiki
//
//  Created by Zhydani Reis benigno  on 30/04/23.
//

import Foundation

class PokemonManager {
    // lista de pokemons
    func getPokemon() -> [Pokemon] {
        // criar variavel que recebe o json
        let data: PokemonPage = Bundle.main.decode(file:"pokemon.json")
        // array que recebe os results do json
        let pokemon: [Pokemon] = data.results
        // retorna a lista
        return pokemon
    }
    // detalhe do pokemon
    func getDetailedPokemon(id: Int, _ completion:@escaping (DetailPokemon) -> ()) {
        // detalhe com base no ID do pokemon
        Bundle.main.fetchData(url: "https://pokeapi.co/api/v2/pokemon/\(id)/", model: DetailPokemon.self) { data in
            // percorre o array de pokemon para exibir o detalhe
            completion(data)
            print(data)
            
        } failure: { error in
            print(error)
        }
    }
}
