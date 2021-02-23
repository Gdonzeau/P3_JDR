//
//  Axe.swift
//  P3_01_JDR
//
//  Created by Guillaume Donzeau on 22/02/2021.
//

import Foundation

class Axe:Weapon {
    override var name: String { "une hache" }
    override var damage: Int { 40 }
    override var number:Int { 5 }
    override var barbarianAuthorized:Bool { true }
    override var druidAuthorized:Bool { false }
    override var paladinAuthorized:Bool { false }
    override var mageAuthorized:Bool { false }
}
