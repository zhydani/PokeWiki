//
//  Helpers.swift
//  PokeWiki
//
//  Created by Zhydani Reis benigno  on 30/04/23.
//

import Foundation

extension Bundle {
    // Realizar o decod do json estatico de pokemons
    func decode<T: Decodable>(file: String) -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Nao foi possivel achar o arquivo \(file) no projeto.")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Nao foi possivel ler o arquivo \(file) do projeto.")
        }
        
        let decoder = JSONDecoder()
        
        guard let loadedData = try? decoder.decode(T.self, from: data) else {
            fatalError("Nao foi possivel realizar o decod do arquivo \(file) do projeto.")
        }
        
        return loadedData
    }
    
    func fetchData<T: Decodable>(url: String, model: T.Type, completion:@escaping(T) -> (), failure:@escaping(Error) -> ()) {
            guard let url = URL(string: url) else { return }
            
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                guard let data = data else {
                    // Se tiver erro, retorna o erro
                    if let error = error { failure(error) }
                    return }
                
                do {
                    let serverData = try JSONDecoder().decode(T.self, from: data)
                    // Retorna sucesso do json do server
                    completion((serverData))
                } catch {
                    failure(error)
                }
            }.resume()
    }
}

