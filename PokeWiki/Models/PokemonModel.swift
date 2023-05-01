//
//  PokemonModel.swift
//  PokeWiki
//
//  Created by Zhydani Reis benigno  on 30/04/23.
//

import Foundation

struct PokemonPage: Codable {
    let count: Int
    let next: String
    let results: [Pokemon]
}

// exata presentation do data, parte inicial do json
struct Pokemon: Codable, Identifiable, Equatable {
    let id = UUID()
    let name: String
    let url: String
    
    // primeiro pokemon exemplo
    static var samplePokemon = Pokemon(name: "bulbasaur", url: "https://pokeapi.co/api/v2/pokemon/1/")
}

// model do detalhe do pokemon
struct DetailPokemon: Codable {
    let id: Int
    let height: Int
    let weight: Int
}
