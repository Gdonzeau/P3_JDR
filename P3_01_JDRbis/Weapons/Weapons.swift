//
//  Weapons.swift
//  P3_01_JDR
//
//  Created by Guillaume Donzeau on 22/02/2021.
//

import Foundation

class Weapon {
    // Chests which contain weapons
    static let allWeapons = [Axe(),BigHealingSpell(),Dagger(),Flail(),Hammer(),HealingSpell(),SwordAndShield(),Fireball(),SmallClub()]
    static var barbarianWeapons = [Weapon]()
    static var paladinWeapons = [Weapon]()
    static var druidWeapons = [Weapon]()
    static var mageWeapons = [Weapon]()
    static var allChests = [barbarianWeapons,druidWeapons,paladinWeapons,mageWeapons]
    
    var name:String {"nothing"} // Pareil que get
    
    var damage:Int {10}
    var armor:Int {0}
    var heals:Bool {false} //Does the equipment heal ?

    // Who can use this piece of equipment ?
    var barbarianAuthorized:Bool {true}
    var druidAuthorized:Bool {true}
    var paladinAuthorized:Bool {true}
    var mageAuthorized:Bool {true}
        
    static func initializingChests() { // Each class has its own chest
        for stuff in Weapon.allWeapons {
            if stuff.barbarianAuthorized {
                Weapon.barbarianWeapons.append(stuff)
            }
            if stuff.paladinAuthorized {
                Weapon.paladinWeapons.append(stuff)
            }
            if stuff.druidAuthorized {
                Weapon.druidWeapons.append(stuff)
            }
            if stuff.mageAuthorized {
                Weapon.mageWeapons.append(stuff)
            }
        }
    }
}
