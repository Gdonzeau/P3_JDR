//
//  Character.swift
//  P3_01_JDR
//
//  Created by Guillaume Donzeau on 23/02/2021.
//

import Foundation

class Character {
    //static var allClasses = [Barbarian,Paladin,Druid,Mage] // Boucle for. Utliser i. Quand i=name, créer la classe ainsi sélectionnée
    static var heroNamesUsed = [String]() // All characters's names
    
    // All types of Characters
    static var allClasses = [Barbarian(name: "", weapon: Weapon()),Druid(name: "", weapon: Weapon()),Paladin(name: "", weapon: Weapon()),Mage(name: "", weapon: Weapon())]
    /*
    static var allClassesCreator = [Barbarian.init(name: "", weapon: Weapon()),Druid.init(name: "", weapon: Weapon()),Paladin.init(name: "", weapon: Weapon()),Mage.init(name: "", weapon: Weapon())]
    */
    
    var name:String
    
    init(name:String,weapon:Weapon) {
        self.name = name
        Character.heroNamesUsed += [name] //each new name is added
        self.weapon = weapon
    }
    var HPInGame = 10
    var weapon:Weapon
    
    var ref:Int { // "column" in the arrays allClasses and allChests
        get {
            return -1
        }
    }
    
    var damage:Int { // Character's damage adapted automatically to the possessed weapon.
        get {
            return weapon.damage
        }
    }
    var magicProtect:Int { // % of chance that a magical protection cancel the attack. If you don't want any magic protection put 0 to every class.
        get {
            return 0
        }
    }
    var HPClass:Int {
        get {
            return 20
        }
    }
    var armor:Int { // The armor will diminish the HP lost.
        get {
            return 0
        }
    }
    var classe:String {
        get {
            return "a character"
        }
    }
    var hobby:String {
        get {
            return "to sleep"
        }
    }
    
    func presentHimSelf() { // The character presents himself
        print ("Hello, my name if \(self.name), I am a \(self.classe).",
               "\nI have \(HPClass) HP and I am equipped with \(self.weapon.name).")
        if self.damage>0 {
            print("In combat I inflict \(self.damage) wounds of damage.")
        }
        else {
            print("In combat I heal \(-self.damage) HP lost.")
        }
        print("In my spare time, I like to \(self.hobby).")
    }
    
    func actionOn(receiver:Character) { // Character's actions : heal or wound
        var realDamage = 0
        if self.damage > 0 { // Of : if self.weapon.heals == false // If character wounds
            if receiver.magicProtection() { // If the magic protection actived itself
                print("\(self.name) attacks \(receiver.name).",
                "\n\(receiver.name)'s magic protection activates ! The attack is stopped !")
            }
            else { // If the magic protection didn't active itself
            realDamage = self.damage - receiver.armor
            print("\(self.name) attacks \(receiver.name)",
                  "\nand inflicts him \(realDamage) wounds of damage.")
            }
        } // If character heals
        else {
            realDamage = self.damage
            print("\(self.name) heals \(receiver.name)",
                  "\n\(receiver.name) recovers \(-self.damage) PV.")
        }
        
        receiver.HPInGame -= realDamage
        if receiver.HPInGame < 0 { // If receiver is under 0 HP
            receiver.HPInGame = 0
        }
        
        if receiver.HPInGame > receiver.HPClass { //If receiver is healed more than max HP
            receiver.HPInGame = receiver.HPClass
        }
        
        print("\(receiver.name) has \(receiver.HPInGame) HP left.") // How many HP left
        
        if receiver.HPInGame == 0 { // 💀
            print("\(receiver.name) is dead.")
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
    
    private func magicProtection()->Bool { // Does magic protection work ?
        if Int(arc4random_uniform(UInt32(100)))+1 < self.magicProtect {
            return true
        }
        else {
            return false
        }
    }
    
}
