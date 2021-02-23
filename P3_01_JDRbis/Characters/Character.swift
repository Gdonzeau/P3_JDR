//
//  Character.swift
//  P3_01_JDR
//
//  Created by Guillaume Donzeau on 23/02/2021.
//

import Foundation

class Character {
    static var allClasses = [String]() // Boucle for. Utliser i. Quand i=name, créer la classe ainsi sélectionnée
    static var heroNamesUsed = [String]()
    
    var name:String
    
    init(name:String) {
        self.name = name
        Character.heroNamesUsed += [name]
    }
    var HPInGame = 10
    /*
    var name:String {
        get {
        return ""
        }
    }
    */
    var damage:Int {
        get {
            return weapon.damage
        }
    }
    var weapon:Weapon {
        get {
            return Dagger()
        }
    }
    var HPClass:Int {
        get {
            return 20
        }
    }
    
    
}
