//
//  MainViewModel.swift
//  PokedexApp
//
//  Created by Deepanshu Bajaj on 19/04/25.
//

import Foundation

class MainViewModel {
    
    private let pokemonManager = PokemonManager()
    var pokemonList = [Pokemon]()
    var pokemonDetails: DetailPokemon?
    
    init() {
        self.pokemonList = pokemonManager.getPokemon()
    }
    
    func getPokemonIndex (pokemon: Pokemon) -> Int {
        if let index =  self.pokemonList.firstIndex(of: pokemon) {
            return index + 1
        }
        return 0
    }
    
    func getIdFromUrl(url: String, completionHandler: @escaping (_ resultId: String?) -> (Void))   {
        _ = ""
        if let range = url.range(of: "/pokemon/") {
            let removedUrlFroString = url[range.upperBound...]
            let pureId = String(removedUrlFroString.dropLast())
            completionHandler(pureId)
        }
    }
    
    func getDetails(pokemon: Pokemon) {
        let id = getPokemonIndex(pokemon: pokemon)
        pokemonManager.getDetailedPokemon(id: id) { data in
            DispatchQueue.main.async {
                self.pokemonDetails = data
            }
        }
    }
    
    func getDetailsWithId(id: Int) {
        pokemonManager.getDetailedPokemon(id: id) { data in
            DispatchQueue.main.async {
                self.pokemonDetails = data
            }
        }
    }
    
    func formatHeighWeight(value: Int) -> String {
        let dValue = Double(value)
        let string = String(format: "%.2f", dValue / 10)
        
        return string
    }
}

