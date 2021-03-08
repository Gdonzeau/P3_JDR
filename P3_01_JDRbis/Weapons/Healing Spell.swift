//
//  Healing Spell.swift
//  P3_01_JDR
//
//  Created by Guillaume Donzeau on 22/02/2021.
//

import Foundation

class HealingSpell:Weapon {
    override var name: String { "a healing spell" }
    override var damage: Int { -30 }
    override var armor: Int { 0 }
    override var heals:Bool { true }
    
    override var barbarianAuthorized:Bool { false }
    override var druidAuthorized:Bool { true }
    override var paladinAuthorized:Bool { true }
    override var mageAuthorized:Bool { true }
}
