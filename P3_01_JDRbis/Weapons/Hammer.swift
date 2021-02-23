//
//  Hammer.swift
//  P3_01_JDR
//
//  Created by Guillaume Donzeau on 22/02/2021.
//

import Foundation

class Hammer:Weapon {
    override var name: String { "un marteau" }
    override var damage: Int { 40 }
    override var number:Int { 2 }
    override var barbarianAuthorized:Bool { false }
    override var druidAuthorized:Bool { false }
    override var paladinAuthorized:Bool { true }
    override var mageAuthorized:Bool { false }
}
