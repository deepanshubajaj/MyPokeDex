//
//  LocalDatabaseManager.swift
//  PokedexApp
//
//  Created by Deepanshu Bajaj on 20/04/25.
//

import Foundation

class LocalDatabaseManager {
    
    static var sampleDetailedPokemon = DetailPokemon(id: 1, height: 1, weight: 1, name: "Pokémon", stats: [], types: [], base_experience: 0)
    
    
    static var getAllObjects: [DetailPokemon] {
        let defaultObject = DetailPokemon(id: 1, height: 1, weight: 1, name: "Pokémon", stats: [], types: [], base_experience: 0)
        if let objects = UserDefaults.standard.value(forKey: "user_objects") as? Data {
            let decoder = JSONDecoder()
            if let objectsDecoded = try? decoder.decode(Array.self, from: objects) as [DetailPokemon] {
                return objectsDecoded
            } else {
                return [defaultObject]
            }
        } else {
            return [defaultObject]
        }
    }
    
    static func saveAllObjects(allObjects: [DetailPokemon]) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(allObjects){
            UserDefaults.standard.set(encoded, forKey: "user_objects")
        }
    }
    
}
