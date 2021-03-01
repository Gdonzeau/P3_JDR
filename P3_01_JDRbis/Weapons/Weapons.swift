//
//  Weapons.swift
//  P3_01_JDR
//
//  Created by Guillaume Donzeau on 22/02/2021.
//

import Foundation

class Weapon {
    // Chests which contain weapons
    static var allWeapons = [Axe(),BigHealingSpell(),Dagger(),Flail(),Hammer(),HealingSpell(),Sword(),Fireball(),SmallClub()]
    static var barbarianWeapons = [Weapon]()
    static var paladinWeapons = [Weapon]()
    static var druidWeapons = [Weapon]()
    static var mageWeapons = [Weapon]()
    static var allChests = [barbarianWeapons,druidWeapons,paladinWeapons,mageWeapons]
    
    var name:String {
        get {
            return "nothing"
        }
    }
    var damage:Int {
        get {
            return 10
        }
    }
    var heals:Bool { //Does the equipment heal ?
        get {
            return false
        }
    }
    // Who can use this piece of equipment ?
    var barbarianAuthorized:Bool {
        get {
            return true
        }
    }
    var druidAuthorized:Bool {
        get {
            return true
        }
    }
    var paladinAuthorized:Bool {
        get {
            return true
        }
    }
    var mageAuthorized:Bool {
        get {
            return true
        }
    }
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
