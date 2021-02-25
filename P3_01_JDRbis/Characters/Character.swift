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
    static var Classes = [Barbarian.self,Druid.self,Paladin.self,Mage.self]
    
    var name:String
    
    init(name:String,weapon:Weapon) {
        self.name = name
        Character.heroNamesUsed += [name]
        self.weapon = weapon
    }
    var HPInGame = 10
    var weapon:Weapon // Si on demande l'arme à la création du perso
    
    var damage:Int {
        get {
            return weapon.damage
        }
    }
    var HPClass:Int {
        get {
            return 20
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
        if self.damage > 0 {
            print("\(self.name) attaque \(receiver.name)",
                  "\net lui inflige \(self.damage) points de dégat.")
        }
        else {
            print("\(self.name) soigne \(receiver.name)",
                  "\n\(receiver.name) récupère \(-self.damage).")
        }
        receiver.HPInGame -= self.damage
    }
    
    func compare(compared:Character)->Character {
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
