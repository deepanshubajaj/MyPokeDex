//
//  PokemonManager.swift
//  PokedexApp
//
//  Created by Deepanshu Bajaj on 20/04/25.
//

import Foundation

class PokemonManager {
    
    func getPokemon() -> [Pokemon] {
        let data: PokemonPage =  NetworkService().decode(url: "\(APIPaths.apiPokemonPage)")
        let pokemon: [Pokemon] = data.results
        
        return pokemon
    }
    
    func getDetailedPokemon(id: Int, _ completion: @escaping (DetailPokemon) -> () ) {
        NetworkService().fetchData(url: "\(APIPaths.apiFetchPokemon)\(id)", model: DetailPokemon.self) { data in
            completion(data)
        } failure: { error in
            print(error.localizedDescription)
        }
    }
}
