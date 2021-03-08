//
//  FireBall.swift
//  P3_01_JDRbis
//
//  Created by Guillaume Donzeau on 26/02/2021.
//

import Foundation

class Fireball:Weapon {
    override var name: String { "a fire ball" }
    override var damage: Int { 50 }
    override var armor: Int { 0 }
    override var heals:Bool { false }
    
    override var barbarianAuthorized:Bool { false }
    override var druidAuthorized:Bool { false }
    override var paladinAuthorized:Bool { false }
    override var mageAuthorized:Bool { true }
}
