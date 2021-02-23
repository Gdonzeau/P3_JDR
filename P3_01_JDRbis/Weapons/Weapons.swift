//
//  Weapons.swift
//  P3_01_JDR
//
//  Created by Guillaume Donzeau on 22/02/2021.
//

import Foundation

class Weapon {
    
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
