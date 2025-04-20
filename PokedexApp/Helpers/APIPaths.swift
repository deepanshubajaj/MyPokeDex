//
//  APIPaths.swift
//  PokedexApp
//
//  Created by Deepanshu Bajaj on 20/04/25.
//

import Foundation

struct APIPaths {
    
    // Api's taken from here: https://pokeapi.co/
    
    static let apiImageUrl = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/"
    static let apiPokemonPage = "https://pokeapi.co/api/v2/pokemon?limit=1000&offset=0"
    static let apiFetchPokemon = "https://pokeapi.co/api/v2/pokemon/"
    static let apiSamplePokemon = "\(APIPaths.apiFetchPokemon)/1/"
    
}
