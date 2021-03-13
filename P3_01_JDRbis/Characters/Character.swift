//
//  Character.swift
//  P3_01_JDR
//
//  Created by Guillaume Donzeau on 23/02/2021.
//

import Foundation

class Character {
    
    static var heroNamesUsed = [String]() // All characters's names
    
    var name:String
    
    init(name:String,weapon:Weapon) {
        self.name = name
        Character.heroNamesUsed.append(name)//each new name is added
        self.weapon = weapon
    }
    var HPInGame = 10
    var weapon:Weapon
    
    var ref:Int {-1} // "column" in the array allChests
    var damage:Int {weapon.damage} // Character's damage adapted automatically to the possessed weapon.
    var armor:Int {weapon.armor} // Character's armor adapted automatically to the possessed weapon.
    var magicProtect:Int {0} // % of chance that a magical protection cancels the attack. If you don't want any magic protection put 0 to every class.
    var HPClass:Int {20}
    var classe:String {"a character"}
    var hobby:String {"to sleep"}
    
    // MARK: - Introducing
    
    func presentHimSelf() { // The character presents himself
        print ("Hello, my name is \(self.name), I am a \(self.classe).",
               "\nI have \(HPClass) HP and I am equipped with \(self.weapon.name).")
        if self.damage>0 {
            print("In combat I inflict \(self.damage) wounds of damage.")
        } else {
            print("In combat I heal \(-self.damage) HP lost.")
        }
        if self.armor > 0 {
            print("I have an armor which gave me a protection of \(self.armor) pts.")
        }
        if self.magicProtect > 0 {
            print("I have a magic protection which works at \(self.magicProtect) %.")
        }
        print("In my spare time, I like to \(self.hobby).")
    }
    
    // MARK: - Fighting
    
    func actionOn(receiver:Character) { // Character's actions : heal or wound
        var realDamage = 0
        if self.damage > 0 {
            
            if receiver.magicProtection() { // If the magic protection actived itself
                print("\(self.name) attacks \(receiver.name).",
                      "\n\(receiver.name)'s magic protection activates ! The attack is stopped !")
            } else { // If the magic protection didn't active itself
                realDamage = self.damage - receiver.armor
                if realDamage <= 0 { // The armor won't heal, just protect
                    realDamage = 0
                    print("\(self.name) attacks \(receiver.name)",
                          "\nbut \(receiver.name)'s armor blocks the attack.")
                } else {
                    print("\(self.name) attacks \(receiver.name)",
                          "\nand inflicts \(realDamage) wounds of damage on him.")
                }
            }
        } else {
            realDamage = self.damage
            print("\(self.name) heals \(receiver.name)",
                  "\n\(receiver.name) recovers and gets \(-self.damage) HP.")
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
    // MARK: - Compare
    
    func compare(compared:Character)->Character {
        var retour:Character
        if damage > compared.damage { // who makes more damage ?
            retour = self
        } else if damage < compared.damage {
            retour = compared
        } else { // Same damages ? How about HP ?
            if HPClass > compared.HPClass {
                retour = self
            } else if HPClass < compared.HPClass {
                retour = compared
            } else { // Same HP ? So who lost less HP. If draw, self wins.
                if HPInGame < compared.HPInGame {
                    retour = compared
                } else {
                    retour = self
                }
            }
        }
        return retour
    }
    
    // MARK: - Magic protection
    private func magicProtection()->Bool { // Does magic protection work ?
        let randomNumber = Int.random(in: 1 ... 100)
            if randomNumber < magicProtect {
            return true
        } else {
            return false
        }
    }
    
}
