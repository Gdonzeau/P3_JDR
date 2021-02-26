//
//  FireBall.swift
//  P3_01_JDRbis
//
//  Created by Guillaume Donzeau on 26/02/2021.
//

import Foundation

class FireBall:Weapon {
    override var name: String { "une boule de feu" }
    override var damage: Int { 50 }
    override var number:Int { 8 }
    override var Heals:Bool { false }
    
    override var barbarianAuthorized:Bool { false }
    override var druidAuthorized:Bool { false }
    override var paladinAuthorized:Bool { false }
    override var mageAuthorized:Bool { true }
}
