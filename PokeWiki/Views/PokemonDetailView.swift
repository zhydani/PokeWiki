//
//  PokemonDetailView.swift
//  PokeWiki
//
//  Created by Zhydani Reis benigno  on 30/04/23.
//

import SwiftUI

struct PokemonDetailView: View {
    @EnvironmentObject var vm: ViewModel
    let pokemon: Pokemon
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                PokemonView(pokemon: pokemon)
                
                VStack(spacing: 10) {
                    HStack {
                        Image(systemName: "number.circle")
                            .font(.system(size: 20))
                        Text("\(vm.pokemonDetails?.id ?? 0)")
                            .font(.title)
                    }
                    
                    HStack {
                        Image(systemName: "scalemass")
                            .foregroundColor(.red) // adicionando cor vermelha ao ícone de peso
                            .font(.system(size: 20)) // aumentando o tamanho do ícone de peso
                        Text("*Weight*: \(vm.formatHW(value: vm.pokemonDetails?.weight ?? 0)) KG")
                            .font(.title2) // usando fonte "title2" para o peso
                    }
                    HStack {
                        Image(systemName: "ruler")
                            .foregroundColor(.green) // adicionando cor verde ao ícone de altura
                            .font(.system(size: 20)) // aumentando o tamanho do ícone de altura
                        Text("*Height*: \(vm.formatHW(value: vm.pokemonDetails?.height ?? 0)) M")
                            .font(.title2) // usando fonte "title2" para a altura
                    }
                    
                }
                .padding()
                .background(Color.white.opacity(0.8))
                .cornerRadius(10)
                .shadow(radius: 5)
                
            }
            .padding()
        }
        .onAppear {
            vm.getDetails(pokemon: pokemon)
        }
    }
}

struct PokemonDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonDetailView(pokemon: Pokemon.samplePokemon)
            .environmentObject(ViewModel())
    }
}
