//
//  Healing Spell.swift
//  P3_01_JDR
//
//  Created by Guillaume Donzeau on 22/02/2021.
//

import Foundation

class HealingSpell:Weapon {
    override var name: String { "un sort de soin" }
    override var damage: Int { -30 }
    override var number:Int { 6 }
    override var barbarianAuthorized:Bool { false }
    override var druidAuthorized:Bool { true }
    override var paladinAuthorized:Bool { true }
    override var mageAuthorized:Bool { true }
}
