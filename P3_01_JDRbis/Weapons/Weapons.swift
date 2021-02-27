//
//  Weapons.swift
//  P3_01_JDR
//
//  Created by Guillaume Donzeau on 22/02/2021.
//

import Foundation

class Weapon {
    // Chests which contains weapons
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
    var number:Int { //Rank in the array
        get {
            return 100
        }
    }
    // Who can use this equipment ?
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
                Weapon.barbarianWeapons += [stuff]
            }
            if stuff.paladinAuthorized {
                Weapon.paladinWeapons += [stuff]
            }
            if stuff.druidAuthorized {
                Weapon.druidWeapons += [stuff]
            }
            if stuff.mageAuthorized {
                Weapon.mageWeapons += [stuff]
            }
        }
    }
    // Just a test, don't pay attention
    /*
    static func subclasses<Weapon>(of theClass: Weapon) -> [Weapon] {
        var count: UInt32 = 0, result: [Weapon] = []
        let allClasses = objc_copyClassList(&count)!

        for n in 0 ..< count {
            let someClass: AnyClass = allClasses[Int(n)]
            guard let someSuperClass = class_getSuperclass(someClass), String(describing: someSuperClass) == String(describing: theClass) else { continue }
            result.append(someClass as! Weapon)
        }

        return result
    }
    */
    func subclass<Weapon>(theClass: Weapon) ->[Weapon] {
        var count: UInt32 = 0, result: [Weapon] = []
        let allClasses = objc_copyClassList(&count)!

        for n in 0 ..< count {
            let someClass: AnyClass = allClasses[Int(n)]
            guard let someSuperClass = class_getSuperclass(someClass), String(describing: someSuperClass) == String(describing: theClass) else { continue }
            result.append(someClass as! Weapon)
        }

        return result
    }
    // End of the test
}
