//
//  Pokemon.swift
//  PokedexApp
//
//  Created by Deepanshu Bajaj on 18/04/25.
//

import Foundation

//MARK: - PokemonPage
struct PokemonPage: Codable {
    let count: Int
    let next: String
    let results: [Pokemon]
}


//MARK: - Pokemon
struct Pokemon: Codable, Identifiable ,Equatable {
    let id = UUID()
    let name: String
    let url: String
    static var samplePokemon = Pokemon(name: "Bulbasaur", url: "\(APIPaths.apiSamplePokemon)")
}


//MARK: - DetailPokemon
struct DetailPokemon: Codable {
    let id: Int
    let height: Int
    let weight: Int
    let name: String
    let stats: [Stat]
    let types: [TypeElement]
    let base_experience: Int
}


//MARK: - Stat
struct Stat: Codable {
    let base_stat: Int
}


//MARK: - TypeElement
struct TypeElement: Codable {
    let slot: Int
    let type: Species
}


//MARK: - Species
struct Species: Codable {
    let name: String
}

