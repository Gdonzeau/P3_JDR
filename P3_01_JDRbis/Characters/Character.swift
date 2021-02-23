//
//  Character.swift
//  P3_01_JDR
//
//  Created by Guillaume Donzeau on 23/02/2021.
//

import Foundation

class Character {
    static var allClasses = ["Barbare","Druide","Paladin","Mage"] // Boucle for. Utliser i. Quand i=name, créer la classe ainsi sélectionnée
    static var heroNamesUsed = [String]()
    
    var name:String
    
    init(name:String,weapon:Weapon) {
        self.name = name
        Character.heroNamesUsed += [name]
        self.weapon = weapon
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
    var weapon:Weapon // Si on demande l'arme à la création du perso
    /*
    var weapon:Weapon {
        get {
            return Dagger()
        }
    }
 */
    var HPClass:Int {
        get {
            return 20
        }
    }
    
    
}
