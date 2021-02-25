//
//  Weapons.swift
//  P3_01_JDR
//
//  Created by Guillaume Donzeau on 22/02/2021.
//

import Foundation

class Weapon {
    static var allWeapons = [Axe(),BigHealingSpell(),Dagger(),Flail(),Hammer(),HealingSpell(),Sword()]
    //static var possibleEquipment = ["une épée","un sort de soin","un poignard","une hache","une masse d'arme"]
    var name:String {
        get {
        return "un petit bâton"
        }
    }
    var damage:Int {
        get {
        return 10
        }
    }
    var Heals:Bool {
        get {
        return false
        }
    }
    var number:Int {
        get {
            return 100
        }
    }
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
}
