//
//  Flail.swift
//  P3_01_JDR
//
//  Created by Guillaume Donzeau on 22/02/2021.
//

import Foundation

class Flail:Weapon {
    override var name: String { "un fléau" }
    override var damage: Int { 45 }
    override var number:Int { 3 }
    override var barbarianAuthorized:Bool { false }
    override var druidAuthorized:Bool { false }
    override var paladinAuthorized:Bool { true }
    override var mageAuthorized:Bool { false }
}
