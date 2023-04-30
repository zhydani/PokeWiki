//
//  PokemonService.swift
//  PokeWiki
//
//  Created by Zhydani Reis benigno  on 30/04/23.
//

import Foundation
import Alamofire

class PokemonService {
    let baseUrl = "https://pokeapi.co/api/v2"
    
    func getAllPokemon(completion: @escaping ([Pokemon]) -> Void) {
        let url = "\(baseUrl)/pokemon?limit=151"
        
        AF.request(url).responseJSON { response in
            if let data = response.data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    if let jsonDict = json as? [String: Any], let results = jsonDict["results"] as? [[String: Any]] {
                        let pokemonList = results.compactMap { dict -> Pokemon? in
                            guard let name = dict["name"] as? String,
                                  let url = dict["url"] as? String else { return nil }
                            let imageUrl = "https://pokeres.bastionbot.org/images/pokemon/\(self.getIdFromUrl(url)).png"
                            return Pokemon(name: name.capitalized, imageUrl: imageUrl, height: 0, weight: 0, types: [])
                        }
                        completion(pokemonList)
                    }
                } catch {
                    print(error)
                }
            }
        }
    }
    
    func getPokemonDetails(url: String, completion: @escaping (Pokemon) -> Void) {
        let url = url.replacingOccurrences(of: "https://pokeapi.co/api/v2", with: "https://pokeapi.co/api/v1")
        
        AF.request(url).responseJSON { response in
            if let data = response.data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    if let jsonDict = json as? [String: Any] {
                        let name = jsonDict["name"] as? String ?? ""
                        let height = jsonDict["height"] as? Int ?? 0
                        let weight = jsonDict["weight"] as? Int ?? 0
                        let types = jsonDict["types"] as? [[String: Any]] ?? []
                        let typeNames = types.compactMap { dict -> String? in
                            guard let typeDict = dict["type"] as? [String: Any],
                                  let typeName = typeDict["name"] as? String else { return nil }
                            return typeName.capitalized
                        }
                        let imageUrl = "https://pokeres.bastionbot.org/images/pokemon/\(self.getIdFromUrl(url)).png"
                        let pokemon = Pokemon(name: name.capitalized, imageUrl: imageUrl, height: height, weight: weight, types: typeNames)
                        completion(pokemon)
                    }
                } catch {
                    print(error)
                }
            }
        }
    }
    
    private func getIdFromUrl(_ url: String) -> Int {
        let components = url.components(separatedBy: "/")
        return Int(components[components.count - 2]) ?? 0
    }
}

