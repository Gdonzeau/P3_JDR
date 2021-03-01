//
//  Axe.swift
//  P3_01_JDR
//
//  Created by Guillaume Donzeau on 22/02/2021.
//

import Foundation

class Axe:Weapon {
    override var name: String { "an axe" }
    override var damage: Int { 40 }
    override var heals:Bool { false }
    
    override var barbarianAuthorized:Bool { true }
    override var druidAuthorized:Bool { false }
    override var paladinAuthorized:Bool { false }
    override var mageAuthorized:Bool { false }
}
