//
//  Pokemon.swift
//  PokeWiki
//
//  Created by Zhydani Reis benigno  on 30/04/23.
//

import Foundation

class Pokemon {
    var name: String
    var imageUrl: String
    var height: Int
    var weight: Int
    var types: [String]
    
    init(name: String, imageUrl: String, height: Int, weight: Int, types: [String]) {
        self.name = name
        self.imageUrl = imageUrl
        self.height = height
        self.weight = weight
        self.types = types
    }
}
