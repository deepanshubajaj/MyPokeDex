//
//  TypeColors.swift
//  PokedexApp
//
//  Created by Deepanshu Bajaj on 18/04/25.
//

import Foundation
import UIKit


class TypeColors {}

extension TypeColors {
    func fetchColor(colorName: String) -> UIColor {
        switch colorName {
        case "flying" :
            return UIColor(named: "flying") ?? UIColor()
        case "poison" :
            return UIColor(named: "poison") ?? UIColor()
        case "ground" :
            return UIColor(named: "ground") ?? UIColor()
        case "rock" :
            return UIColor(named: "rock") ?? UIColor()
        case "bug" :
            return UIColor(named: "bug") ?? UIColor()
        case "ghost" :
            return UIColor(named: "bug") ?? UIColor()
        case "steel" :
            return UIColor(named: "steel") ?? UIColor()
        case "fire" :
            return UIColor(named: "fire") ?? UIColor()
        case "water" :
            return UIColor(named: "water") ?? UIColor()
        case "grass" :
            return UIColor(named: "grass") ?? UIColor()
        case "electric" :
            return UIColor(named: "electric") ?? UIColor()
        case "psychic" :
            return UIColor(named: "psychic") ?? UIColor()
        case "ice" :
            return UIColor(named: "ice") ?? UIColor()
        case "fairy" :
            return UIColor(named: "fairy") ?? UIColor()
        case "dragon" :
            return UIColor(named: "dragon") ?? UIColor()
        case "dark" :
            return UIColor(named: "dark") ?? UIColor()
        default:
            return UIColor(named: "gray") ?? UIColor()
        }
        
    }
    
}
