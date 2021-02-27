//
//  Dagger.swift
//  P3_01_JDR
//
//  Created by Guillaume Donzeau on 22/02/2021.
//

import Foundation

class Dagger:Weapon {
    override var name: String { "a dagger" }
    override var damage: Int { 15 }
    override var number:Int { 4 }
    override var heals:Bool { false }
    
    override var barbarianAuthorized:Bool { true }
    override var druidAuthorized:Bool { true }
    override var paladinAuthorized:Bool { true }
    override var mageAuthorized:Bool { true }
}
