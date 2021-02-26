//
//  Character.swift
//  P3_01_JDR
//
//  Created by Guillaume Donzeau on 23/02/2021.
//

import Foundation

class Character {
    //static var allClasses = [Barbarian,Paladin,Druid,Mage] // Boucle for. Utliser i. Quand i=name, créer la classe ainsi sélectionnée
    static var heroNamesUsed = [String]()
    static var allClasses = [Barbarian(name: "", weapon: Weapon()),Druid(name: "", weapon: Weapon()),Paladin(name: "", weapon: Weapon()),Mage(name: "", weapon: Weapon())]
    
    var name:String
    
    init(name:String,weapon:Weapon) {
        self.name = name
        Character.heroNamesUsed += [name]
        self.weapon = weapon
    }
    var HPInGame = 10
    var weapon:Weapon
    
    var damage:Int {
        get {
            return weapon.damage
        }
    }
    var symbol:String {
        get {
            return "😀"
        }
    }
    var HPClass:Int {
        get {
            return 20
        }
    }
    var armor:Int {
        get {
            return 0
        }
    }
    var classe:String {
        get {
            return "un personnage"
        }
    }
    var hobby:String {
        get {
            return "me tourner les pouces"
        }
    }
    
    func presentHimSelf() {
        print ("Bonjour, je m'appelle \(self.name), je suis \(self.classe).",
               "\nJ'ai \(HPClass) PV et je suis équipé d'\(self.weapon.name).")
        if self.damage>0 {
            print("Au combat j'inflige \(self.damage) PV de dommage.")
        }
        else {
            print("Au combat je soigne \(-self.damage) PV perdus.")
        }
        print("À mes heures perdues, j'aime bien \(self.hobby).")
    }
    
    func actionOn(receiver:Character) {
        var realDamage = 0
        if self.damage > 0 {
            realDamage = self.damage - receiver.armor
            print("\(self.name) attaque \(receiver.name)",
                  "\net lui inflige \(realDamage) points de dégat.")
        }
        else {
            realDamage = self.damage
            print("\(self.name) soigne \(receiver.name)",
                  "\n\(receiver.name) récupère \(-self.damage).")
        }
        receiver.HPInGame -= realDamage
        if receiver.HPInGame < 0 {
            receiver.HPInGame = 0
        }
        
        if receiver.HPInGame == 0 {
            print("\(receiver.name) est mort.")
        }
        
        if receiver.HPInGame > receiver.HPClass {
            receiver.HPInGame = receiver.HPClass
        }
    }
    
    func compare(compared:Character)->Character { // Utiliser des tuples ?
        var retour:Character
        if self.damage > compared.damage {
            retour = self
        }
        else if self.damage < compared.damage {
            retour = compared
        }
         else { // Les dommages sont égaux, on compare les PV de classe
            if self.HPClass > compared.HPClass {
                retour = self
            }
            else if self.HPClass < compared.HPClass {
                retour = compared
            }
            else {
                if self.HPInGame < compared.HPInGame {
                    retour = compared
                }
                else {
                    retour = self
                }
            }
        }
        return retour
    }
    
}
